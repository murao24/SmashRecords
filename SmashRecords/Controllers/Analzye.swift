//
//  AnalyzeViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class Analyze {
    
    let realm = try! Realm()

    private var records: Results<Record>?
    private var analyzeByMyFighters: Results<AnalyzeByMyFighter>?
    private var analyzeByOpponentFighters: Results<AnalyzeByOpponentFighter>?
    private var analyzeByStages: Results<AnalyzeByStage>?
    
    
    func analyzeRecord(myFighter: String, opponentFighter: String, stage: String) {
        
        
        // myFighter
        let newAnalyzeByMyFighter = AnalyzeByMyFighter()
        newAnalyzeByMyFighter.myFighter = myFighter
        var myGame = 0
        var myWin = 0
        
        records = realm.objects(Record.self).filter("myFighter == %@", myFighter)
        if records?.count != 0 {
            if let records = records {
                myGame = records.count
            }
            
            records = records?.filter("result == true")
            if let records = records {
                myWin = records.count
            }
            
            newAnalyzeByMyFighter.game = myGame
            newAnalyzeByMyFighter.win = myWin
            newAnalyzeByMyFighter.lose = myGame - myWin
            newAnalyzeByMyFighter.winRate = Float(CGFloat(myWin) / CGFloat(myGame) * 100)
        } else {
            newAnalyzeByMyFighter.game = 0
            newAnalyzeByMyFighter.win = 0
            newAnalyzeByMyFighter.lose = 0
            newAnalyzeByMyFighter.winRate = 0
        }
        update(record: newAnalyzeByMyFighter)

        
        // opponentFighter
        let newAnalyzeByOpponentFighter = AnalyzeByOpponentFighter()
        newAnalyzeByOpponentFighter.opponentFighter = opponentFighter
        var opponentGame = 0
        var opponentWin = 0
        
        records = realm.objects(Record.self).filter("opponentFighter == %@", opponentFighter)
        if records?.count != 0 {
            if let records = records {
                opponentGame = records.count
            }
            
            records = records?.filter("result == true")
            if let records = records {
                opponentWin = records.count
            }
            
            newAnalyzeByOpponentFighter.game = opponentGame
            newAnalyzeByOpponentFighter.win = opponentWin
            newAnalyzeByOpponentFighter.lose = opponentGame - opponentWin
            newAnalyzeByOpponentFighter.winRate = Float(CGFloat(opponentWin) / CGFloat(opponentGame) * 100)
        } else {
            newAnalyzeByOpponentFighter.game = 0
            newAnalyzeByOpponentFighter.win = 0
            newAnalyzeByOpponentFighter.lose = 0
            newAnalyzeByOpponentFighter.winRate = 0
        }
        update(record: newAnalyzeByOpponentFighter)
        
        // stage
        let newAnalyzeByStage = AnalyzeByStage()
        newAnalyzeByStage.stage = stage
        var stageGame = 0
        var stageWin = 0
        
        records = realm.objects(Record.self).filter("stage == %@", stage)
        if records?.count != 0 {
            if let records = records {
                stageGame = records.count
            }
            
            records = records?.filter("result == true")
            if let records = records {
                stageWin = records.count
            }
            
            newAnalyzeByStage.game = stageGame
            newAnalyzeByStage.win = stageWin
            newAnalyzeByStage.lose = stageGame - stageWin
            newAnalyzeByStage.winRate = Float(CGFloat(stageWin) / CGFloat(stageGame) * 100)
        } else {
            newAnalyzeByStage.game = 0
            newAnalyzeByStage.win = 0
            newAnalyzeByStage.lose = 0
            newAnalyzeByStage.winRate = 0
        }
        update(record: newAnalyzeByStage)

    }
    

    
    func update(record: Object) {
        do {
            try realm.write {
                realm.add(record, update: .modified)
            }
        } catch {
            print("Error updating object\(error)")
        }
    }
    
    


}
