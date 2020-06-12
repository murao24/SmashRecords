//
//  MainFighter.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/12.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class MainFighter: Object {
    
    @objc dynamic var mainFighter: String = "mario"
    @objc dynamic var ID: Int = 0
    
    override static func primaryKey() -> String? {
        return "ID"
    }
    
}
