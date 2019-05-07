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

    let realm = try! Realm()
    var ansArray:Results<IntroModel>!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var answerLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ansArray = realm.objects(IntroModel.self)
        
        print(ansArray.count)
        do {
            let realm2 = try Realm()
            try! realm2.write {
                //realm2.deleteAll()
                print(ansArray.count)
            }
        } catch {
        }
        //answerLabel.text = ansArray[ansArray.count-1].ans
        //answerLabel2.text = ansArray[0].ans
    }

}
