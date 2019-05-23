//
//  IntroModel.swift
//  IntroApp
//
//  Created by 林香穂 on 2019/05/05.
//  Copyright © 2019 林香穂. All rights reserved.
//

import Foundation
import RealmSwift

class QuestionModel: Object{
    @objc dynamic var question: String = ""
    @objc dynamic var id = 0
    
}

class IntroModel: Object{
    let answer = List<AnswerModel>()
    @objc dynamic var today: String = ""
    @objc dynamic var id = 0
    @objc dynamic var title: String = ""
}

class AnswerModel: Object{
    @objc dynamic var ans: String = ""
    @objc dynamic var questionNum: Int = 0
}
