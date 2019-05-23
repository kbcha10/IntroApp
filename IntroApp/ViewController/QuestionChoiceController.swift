//
//  QuestionChoiceController.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/17.
//  Copyright © 2019 林香穂. All rights reserved.
//


//セルのチェック管理に注意

import UIKit
import RealmSwift


class QuestionChoiceController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let realm = try! Realm()
    
    //Questionモデルを読み込み
    var QuestionArray:Results<QuestionModel>!
    var IntroArray:Results<IntroModel>!
    var questionNum: [Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionArray = realm.objects(QuestionModel.self)
        IntroArray = realm.objects(IntroModel.self)
        
        //Questionモデルに何も質問がなければデフォルトの質問を追加
        if (QuestionArray.count<1){
            let firstQuestions = [
                QuestionModel(value: ["question":"好きな食べ物はなんですか" , "id":0]),
                QuestionModel(value: ["question":"ニックネームはなんですか" , "id":1]),
                QuestionModel(value: ["question":"好きな曲はなんですか" , "id":2]),
                QuestionModel(value: ["question":"好きなゲームはなんですか" , "id":3])
            ]
            try! realm.write{
                realm.add(firstQuestions)
            }
        }
        
        //セルのチェック管理初期値
        for i in 0..<QuestionArray.count{
            questionNum.append(0)
        }
        
        tableView.register(UINib(nibName: "QuestionCell", bundle: nil),forCellReuseIdentifier: "questionCell")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セクションごとにデータ要素数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionArray.count
    }
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*// セクションヘッダ
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
     return sectionName[section]
     }*/
    
    // セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    // セル生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionCell
        cell.questionLabel!.text = QuestionArray[indexPath.row].question
        
        return cell
    }
    
    /*// セクションヘッダの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }*/
    
    //セル選択時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        if cell?.accessoryType != .checkmark {
            // チェックマークを入れる&チェック管理配列の更新
            cell?.accessoryType = .checkmark
            questionNum[indexPath.row]=1
        } else {
            cell?.accessoryType = .none
            questionNum[indexPath.row]=0
        }
    }
    
    //セル削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(realm.objects(QuestionModel.self)[indexPath.row])
                //id番号をずらす
                for i in indexPath.row..<QuestionArray.count{
                    realm.objects(QuestionModel.self)[i].id = realm.objects(QuestionModel.self)[i].id-1
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func starIntroduction(){
        
        //チェックのついている質問の数を数える
        var countQuestion:Int = 0
        for i in 0..<questionNum.count{
            if(questionNum[i]==1){
                countQuestion += 1
            }
        }
        //質問が一つ以上あるなら
        if(countQuestion>0){
            //新しいIntroモデルの登録
            let intro = IntroModel()
            let f = DateFormatter()
            f.timeStyle = .none
            f.dateStyle = .medium
            f.locale = Locale(identifier: "ja_JP")
            intro.id = IntroArray.count
            intro.today = f.string(from: Date())
            let alert = UIAlertController(title: "タイトル", message: "自己紹介のタイトルを入力してください", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
            let okayButton = UIAlertAction(title: "決定", style: UIAlertAction.Style.default, handler: {[weak alert] (action) -> Void in
                guard let textFields = alert?.textFields else {
                    return
                }
                guard !textFields.isEmpty else {
                    return
                }
                //追加ボタンを押した時に質問をRealmに保存
                for text in textFields {
                    intro.title = text.text!
                    try! self.realm.write{
                        self.realm.add(intro)
                    }
                }
                for i in 0..<self.questionNum.count{
                    if(self.questionNum[i]==1){
                        let answer = AnswerModel()
                        answer.questionNum=i
                        try! self.realm.write {
                            intro.answer.append(answer)
                        }
                    }
                }
                self.performSegue(withIdentifier: "toQuestionView", sender: nil)
            })
            alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
                text.placeholder = "タイトルを入力"
            })
            
            alert.addAction(okayButton)
            alert.addAction(cancelButton)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    //新しい質問の追加
    @IBAction func displayAlert() {
        let alert = UIAlertController(title: "質問を追加", message: "追加したい質問を入力してください", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        let okayButton = UIAlertAction(title: "追加", style: UIAlertAction.Style.default, handler: {[weak alert] (action) -> Void in
            guard let textFields = alert?.textFields else {
                return
            }
            
            guard !textFields.isEmpty else {
                return
            }
            
            //追加ボタンを押した時に質問をRealmに保存
            for text in textFields {
                let question = QuestionModel()
                question.question = text.text!
                question.id=self.QuestionArray.count
                try! self.realm.write {
                    self.realm.add(question)
                }
                //テーブルに反映&チェック管理配列の更新
                self.tableView.reloadData()
                self.questionNum.append(0)
            }
        })
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            
        })
        
        alert.addAction(okayButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
}
    

    

    




