//
//  Notes.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    
    @objc dynamic var parentFighterName: String = ""
    @objc dynamic var note: String = ""
    
    override static func primaryKey() -> String? {
        return "parentFighterName"
    }

}
