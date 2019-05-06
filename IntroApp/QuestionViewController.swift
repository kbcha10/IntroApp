import UIKit
import RealmSwift

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var isAnsweredLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
    
    var isAnswered: Bool = false   //回答したか。次の問題に行くかの判定
    var wordArray: [Dictionary<String, String>] = []    //UserDefaultsからとる配列
    var quizArray: [String]!
    var shuffledWordArray: [Dictionary<String, String>] = []  //シャッフルされた配列
    var nowNumber: Int=0  //現在の回答数現在の回答数

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.text = ""
        isAnsweredLabel.isHidden=true//「回答が入力されていません！」を隠す
        
        //quizArray=["好きな食べ物はなんですか","ニックネームはなんですか","好きな曲はなんですか","好きなゲームはなんですか"]
        quizArray=["好きな食べ物はなんですか","ニックネームはなんですか"]
    }
    
    //viewが現れた時によばれる
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        questionLabel.text = quizArray[nowNumber]
    }
    
    @IBAction func nextButtonTapped(_ sender: Any){
        //回答したか確認
        if answerTextField.text != "" {
            isAnswered = true
        }
        //回答していたら
        if isAnswered{
            let intro:IntroModel = IntroModel()
            intro.ans = answerTextField.text!
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(intro)
            }
            
            //次の問題へ
            nowNumber += 1
            answerTextField.text = ""
            
            //次の問題を表示するか
            if nowNumber < quizArray.count{
                //次の問題を表示
                questionLabel.text = quizArray[nowNumber]
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
            questionLabel.text = quizArray[nowNumber]
            //isAnsweredをfalseにする
            isAnswered = false
        } else {
            //これ以上表示する問題がないので、Finishビューに遷移
            self.performSegue(withIdentifier: "toFinishView", sender: nil)
        }
    }
}
