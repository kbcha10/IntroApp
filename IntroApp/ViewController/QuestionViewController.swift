import UIKit
import RealmSwift

class QuestionViewController: UIViewController {
    
    let realm = try! Realm()
    
    var IntroArray:Results<IntroModel>!
    var QuestionArray:Results<QuestionModel>!
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var isAnsweredLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
    
    var isAnswered: Bool = false   //そのページの問題に回答しているか（文字が入力されているか）
    var nowNumber: Int=0  //現在の回答数
    
    var intro = IntroModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////////IntroモデルとQuestionモデルの読み込み////////
        IntroArray = realm.objects(IntroModel.self)
        QuestionArray = realm.objects(QuestionModel.self)
        intro = IntroArray[IntroArray.count-1]
        //////////////////////////////////////////////////
        
        ////////IntroモデルとQuestionモデルのモデルの数////////  <-プライマリキーの値の設定に使うよ
        let IntroCount = IntroArray.count
        let QuestionCount = QuestionArray.count
        //////////////////////////////////////////////////
        
        //画面の初期設定
        isAnsweredLabel.isHidden=true//「回答が入力されていません！」を隠す
        QuestionArray = realm.objects(QuestionModel.self)
        questionLabel.text = QuestionArray[intro.answer[nowNumber].questionNum].question
    }
    
    //viewが現れた時によばれる
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)

    }
    
    @IBAction func nextButtonTapped(_ sender: Any){
        //回答したか確認
        if answerTextField.text != "" {
            isAnswered = true
        }
        //回答していたら
        if isAnswered{
            
            //Answerモデルの登録
            try! realm.write {
                intro.answer[nowNumber].ans = answerTextField.text!
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
        if nowNumber < intro.answer.count{
            //次の問題を表示
            questionLabel.text = QuestionArray[intro.answer[nowNumber].questionNum].question
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
