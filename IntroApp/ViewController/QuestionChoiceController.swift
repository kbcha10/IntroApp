//
//  QuestionChoiceController.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/17.
//  Copyright © 2019 林香穂. All rights reserved.
//

import UIKit
import RealmSwift


class QuestionChoiceController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let realm = try! Realm()
    
    //Questionモデルを読み込み
    var QuestionArray:Results<QuestionModel>!
    var questionNum: [Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionArray = realm.objects(QuestionModel.self)
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
        questionNum=[]
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
        if (cell.isChecked){
            questionNum.append(indexPath.row)
        }
        print(questionNum)
        return cell
    }
    
    // セクションヘッダの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //セル選択時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        if cell?.accessoryType != .checkmark {
            // チェックマークを入れる
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
    }
    
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
            
            //OKボタンを押した時に質問をRealmに保存
            for text in textFields {
                let QuestionCount = self.QuestionArray.count
                let question = QuestionModel()
                question.question = text.text!
                question.id=QuestionCount
                try! self.realm.write {
                    self.realm.add(question)
                }
                //テーブルに反映
                self.tableView.reloadData()
            }
        })
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            
        })
        
        alert.addAction(okayButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
}
    

    

    




