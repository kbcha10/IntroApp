//
//  TopViewController.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/09.
//  Copyright © 2019 林香穂. All rights reserved.
//

import UIKit
import RealmSwift

class TopViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Realmのファイルの場所読み込み
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    @IBAction func back(segue: UIStoryboardSegue){
    }

}
