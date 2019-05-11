//
//  IntroduceTableViewController.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/09.
//  Copyright © 2019 林香穂. All rights reserved.
//

import UIKit

import UIKit
import RealmSwift

class IntroduceTableViewController: UITableViewController {
    
    //let config2 = Realm.Configuration(inMemoryIdentifier: "inMemory")
    //let realm = try! Realm(configuration:config2)
    let realm = try! Realm()
    
    //IntroモデルとQuestionモデルを読み込み
    var IntroArray:Results<IntroModel>!
    var QuestionArray:Results<QuestionModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //IntroモデルとQuestionモデルを読み込み
        IntroArray = realm.objects(IntroModel.self)
        QuestionArray = realm.objects(QuestionModel.self)
        
        tableView.register(UINib(nibName: "IntroduceTableViewCell", bundle: nil),forCellReuseIdentifier: "introCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IntroArray[selectedIntro].answer.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "introCell", for: indexPath) as! IntroduceTableViewCell
        
        let num:Int = IntroArray[selectedIntro].answer[indexPath.row].questionNum
        cell.questionLabel!.text = QuestionArray[num].question
        cell.answerLabel!.text = IntroArray[selectedIntro].answer[indexPath.row].ans
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pushedButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    
}
