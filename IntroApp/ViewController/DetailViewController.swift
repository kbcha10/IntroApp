//
//  DetailViewController.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/06.
//  Copyright © 2019 林香穂. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {

    var IntroArray:Results<IntroModel>!
    var QuestionArray:Results<QuestionModel>!
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var answerLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let config2 = Realm.Configuration(inMemoryIdentifier: "inMemory")
        //let realm = try! Realm(configuration:config2)
        let realm = try! Realm()
        
        IntroArray = realm.objects(IntroModel.self)
        QuestionArray = realm.objects(QuestionModel.self)
        
        let num:Int = IntroArray[0].answer[0].questionNum
        answerLabel.text = QuestionArray[num].question
        answerLabel2.text = IntroArray[0].answer[0].ans
    }

}
