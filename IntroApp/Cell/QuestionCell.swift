//
//  QuestionCell.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/17.
//  Copyright © 2019 林香穂. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    var isChecked:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pushCheck(){
        if (!isChecked){
            isChecked=true
            checkButton.setTitle("✔️", for: .normal)
        }
        else{
            isChecked=false
            checkButton.setTitle("○", for: .normal)
        }
        
    }
    
}
