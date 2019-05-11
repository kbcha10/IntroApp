import UIKit
import RealmSwift

class QuestionViewController: UIViewController {
    
    //let config2 = Realm.Configuration(inMemoryIdentifier: "inMemory")
    //let realm = try! Realm(configuration:config2)
    let realm = try! Realm()
    
    var IntroArray:Results<IntroModel>!
    var QuestionArray:Results<QuestionModel>!
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var isAnsweredLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
    
    var isAnswered: Bool = false   //そのページの問題に回答しているか（文字が入力されているか）
    var shuffledWordArray: [Dictionary<String, String>] = []  //シャッフルされた配列
    var nowNumber: Int=0  //現在の回答数

    var quizArray:Results<QuestionModel>!
    
    let intro = IntroModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////////IntroモデルとQuestionモデルの読み込み////////
        IntroArray = realm.objects(IntroModel.self)
        QuestionArray = realm.objects(QuestionModel.self)
        //////////////////////////////////////////////////
        
        ////////IntroモデルとQuestionモデルのモデルの数////////  <-プライマリキーの値の設定に使うよ
        let IntroCount = IntroArray.count
        let QuestionCount = QuestionArray.count
        //////////////////////////////////////////////////
        
        //Questionモデルに何も質問がなければデフォルトの質問を追加
        if (QuestionCount<1){
            let questions = [
                QuestionModel(value: ["question":"好きな食べ物はなんですか" , "id":0]),
                QuestionModel(value: ["question":"ニックネームはなんですか" , "id":1]),
                QuestionModel(value: ["question":"好きな曲はなんですか" , "id":2]),
                QuestionModel(value: ["question":"好きなゲームはなんですか" , "id":3])
            ]
            try! realm.write{
                realm.add(questions)
            }
        }
        
        //新しいIntroモデルの登録
        let f = DateFormatter()
        f.timeStyle = .none
        f.dateStyle = .medium
        f.locale = Locale(identifier: "ja_JP")
        intro.id = IntroCount
        intro.today = f.string(from: Date())
        try! realm.write{
            realm.add(intro)
        }
        
        //画面の初期設定
        isAnsweredLabel.isHidden=true//「回答が入力されていません！」を隠す
        quizArray = realm.objects(QuestionModel.self)
    }
    
    //viewが現れた時によばれる
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        questionLabel.text = quizArray[nowNumber].question
    }
    
    @IBAction func nextButtonTapped(_ sender: Any){
        //回答したか確認
        if answerTextField.text != "" {
            isAnswered = true
        }
        //回答していたら
        if isAnswered{
            
            //Answerモデルの登録
            let answer = AnswerModel()
            answer.ans = answerTextField.text!
            answer.questionNum=nowNumber
            try! realm.write {
                intro.answer.append(answer)
            }
            
            nextQuestion()
            
        } else {
            //「入力されていません！」
            isAnsweredLabel.isHidden=false
        }
    }
    
    @IBAction func skipButtonTapped(){
        nextQuestion()
    }
    
    //質問画面
    func nextQuestion(){
        nowNumber += 1
        answerTextField.text = ""
        
        //次の問題を表示するか
        if nowNumber < quizArray.count{
            //次の問題を表示
            questionLabel.text = quizArray[nowNumber].question
            //isAnsweredをfalseにする
            isAnswered = false
            isAnsweredLabel.isHidden=true
        } else {
            //これ以上表示する問題がないので、Finishビューに遷移
            nowNumber = 0
            self.performSegue(withIdentifier: "toFinishView", sender: nil)
        }
    }
}
