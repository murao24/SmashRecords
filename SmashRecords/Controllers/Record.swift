//
//  Record.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import RealmSwift

class Record: Object {
    
    @objc dynamic var result: Bool = true
    @objc dynamic var myFighter: String = ""
    @objc dynamic var opponentFighter: String = ""
    @objc dynamic var stage: String = ""
    @objc dynamic var date = Date()

}
