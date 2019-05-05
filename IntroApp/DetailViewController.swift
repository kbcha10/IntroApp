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
    var ansArray: Results<IntroModel>!
    @IBOutlet var titleLabel1:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ansArray = realm.objects(IntroModel.self)
        titleLabel1.text = ansArray[0].ans
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
