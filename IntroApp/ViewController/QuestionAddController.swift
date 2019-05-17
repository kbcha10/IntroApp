//
//  QuestionAddController.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/17.
//  Copyright © 2019 林香穂. All rights reserved.
//

import UIKit
import RealmSwift

class QuestionAddController: UIViewController {

    let realm = try! Realm()
    
    @IBOutlet var questionTextField: UITextField!
    var QuestionArray:Results<QuestionModel>!
    let questions = QuestionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        QuestionArray = realm.objects(QuestionModel.self)
    }
    
    @IBAction func addQuestion(){
        let QuestionCount = QuestionArray.count
        questions.question = questionTextField.text!
        questions.id=QuestionCount
        try! realm.write {
            realm.add(questions)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
