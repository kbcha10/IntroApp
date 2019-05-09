//
//  DateTableViewController.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/09.
//  Copyright © 2019 林香穂. All rights reserved.
//

import UIKit
import RealmSwift

var selectedIntro: Int!

class DateTableViewController: UITableViewController {

    var IntroArray:Results<IntroModel>!
    var selectIntro: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let config2 = Realm.Configuration(inMemoryIdentifier: "inMemory")
        let realm = try! Realm(configuration:config2)
        
        IntroArray = realm.objects(IntroModel.self)
        tableView.register(UINib(nibName: "DataTableViewCell", bundle: nil),forCellReuseIdentifier: "cell")
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IntroArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableViewCell
        cell.dateLabel!.text = IntroArray[indexPath.row].today
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたセルの行番号を出力
        selectedIntro=indexPath.row
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        // 別の画面に遷移
        performSegue(withIdentifier: "toIntroduceTableView", sender: nil)
    }
    
}
