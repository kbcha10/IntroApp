import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var isAnsweredLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
    
    var isAnswered: Bool = false   //回答したか。次の問題に行くかの判定
    var wordArray: [Dictionary<String, String>] = []    //UserDefaultsからとる配列
    var quizArray: [String]!
    var shuffledWordArray: [Dictionary<String, String>] = []  //シャッフルされた配列
    var nowNumber: Int=0  //現在の回答数現在の回答数

    
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.text = ""
        isAnsweredLabel.isHidden=true//「回答が入力されていません！」を隠す
        
        quizArray=["好きな食べ物はなんですか","ニックネームはなんですか","好きな曲はなんですか","好きなゲームはなんですか"]
    }
    
    
    //viewが現れた時によばれる
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        questionLabel.text = quizArray[nowNumber]
    }
    
    @IBAction func nextButtonTapped(){
        //回答したか確認
        if answerTextField.text != "" {
            isAnswered = true
        }
        //回答していたら
        if isAnswered{
            //次の問題へ
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
