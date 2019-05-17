//
//  QuestionChoiceController.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/17.
//  Copyright © 2019 林香穂. All rights reserved.
//

import UIKit
import RealmSwift

class QuestionChoiceController: UITableViewController {

    
    let realm = try! Realm()
    
    //Questionモデルを読み込み
    var QuestionArray:Results<QuestionModel>!
    var questionNum: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //IntroモデルとQuestionモデルを読み込み
        QuestionArray = realm.objects(QuestionModel.self)
        
        tableView.register(UINib(nibName: "QuestionCell", bundle: nil),forCellReuseIdentifier: "questionCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        questionNum=[]
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionCell
        cell.questionLabel!.text = QuestionArray[indexPath.row].question
        if (cell.isChecked){
            questionNum.append(indexPath.row)
        }
        print(questionNum)
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        if cell?.accessoryType != .checkmark {
            // チェックマークを入れる
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        /*let vc = storyboard!.instantiateViewController(withIdentifier:"NextViewController") as! NextViewController
        vc.quizArray = questionNum*/
        
    }
    
    

}
