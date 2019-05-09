//
//  IntroduceTableViewCell.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/09.
//  Copyright © 2019 林香穂. All rights reserved.
//

import UIKit

class IntroduceTableViewCell: UITableViewCell {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
