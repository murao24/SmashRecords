//
//  AnalyzeByStage.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class AnalyzeByStage: Object {
    
    @objc dynamic var stage = ""
    @objc dynamic var stageID = 0
    @objc dynamic var game = 0
    @objc dynamic var win = 0
    @objc dynamic var lose = 0
    @objc dynamic var winRate: Float = 0.0

    override static func primaryKey() -> String? {
        return "stage"
    }

}
