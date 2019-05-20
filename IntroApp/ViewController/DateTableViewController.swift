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
    
    //let config2 = Realm.Configuration(inMemoryIdentifier: "inMemory")
    //let realm = try! Realm(configuration:config2)
    let realm = try! Realm()

    var IntroArray:Results<IntroModel>!
    var selectIntro: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IntroArray = realm.objects(IntroModel.self)
        tableView.register(UINib(nibName: "DataTableViewCell", bundle: nil),forCellReuseIdentifier: "cell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セル削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(realm.objects(IntroModel.self)[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IntroArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableViewCell
        cell.dateLabel!.text = IntroArray[indexPath.row].today
        
        return cell
    }
    //選択された日付の自己紹介を次の画面で表示
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたセルの行番号を出力
        selectedIntro=indexPath.row
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        // 別の画面に遷移
        performSegue(withIdentifier: "toIntroduceTableView", sender: nil)
    }
    @IBAction func pushedButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
