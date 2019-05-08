import UIKit
import RealmSwift

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var isAnsweredLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
    
    var isAnswered: Bool = false   //回答したか。次の問題に行くかの判定
    var wordArray: [Dictionary<String, String>] = []    //UserDefaultsからとる配列
    var shuffledWordArray: [Dictionary<String, String>] = []  //シャッフルされた配列
    var nowNumber: Int=0  //現在の回答数現在の回答数

    var quizArray:Results<QuestionModel>!
    
    let intro = IntroModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.text = ""
        isAnsweredLabel.isHidden=true//「回答が入力されていません！」を隠す
        
        let config2 = Realm.Configuration(inMemoryIdentifier: "inMemory")
        let realm = try! Realm(configuration:config2)
        let questions = [
            QuestionModel(value: ["question":"好きな食べ物はなんですか" , "id":0]),
            QuestionModel(value: ["question":"ニックネームはなんですか" , "id":1]),
            QuestionModel(value: ["question":"好きな曲はなんですか" , "id":2]),
            QuestionModel(value: ["question":"好きなゲームはなんですか" , "id":3])
        ]
        
        try! realm.write{
            realm.add(questions)
            realm.add(intro)
        }
        
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
            
            let answer = AnswerModel()
            answer.ans = answerTextField.text!
            answer.questionNum=nowNumber
            
            let config2 = Realm.Configuration(inMemoryIdentifier: "inMemory")
            let realm = try! Realm(configuration:config2)
            try! realm.write {
                intro.answer.append(answer)
                print(intro.answer)
            }
            
            //次の問題へ
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
                self.performSegue(withIdentifier: "toFinishView", sender: nil)
            }
        } else {
            //「入力されていません！」を表示する
            isAnsweredLabel.isHidden=false
        }
    }
    @IBAction func skipButtonTapped(){
        nowNumber += 1
        answerTextField.text = ""
        
        //次の問題を表示するか
        if nowNumber < quizArray.count{
            //次の問題を表示
            questionLabel.text = quizArray[nowNumber].question
            //isAnsweredをfalseにする
            isAnswered = false
        } else {
            //これ以上表示する問題がないので、Finishビューに遷移
            self.performSegue(withIdentifier: "toFinishView", sender: nil)
        }
    }
}
