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
    
    
    func analyzeRecord() {
        
        records = realm.objects(Record.self)
        
        for i in 0...S.fightersArray.count - 1 {
            
            // myFighter
            let myGame = records?.filter("myFighter == %@", S.fightersArray[i][1])
            let myWin = myGame?.filter("result == true")
            let newAnalyzeByMyFighter = AnalyzeByMyFighter()
            
            newAnalyzeByMyFighter.myFighter = S.fightersArray[i][1]
            newAnalyzeByMyFighter.fighterID = i
            
            if let game = myGame, let win = myWin {
                newAnalyzeByMyFighter.game = game.count
                newAnalyzeByMyFighter.win = win.count
                newAnalyzeByMyFighter.lose = game.count - win.count
                newAnalyzeByMyFighter.winRate = Float(CGFloat(win.count) / CGFloat(game.count) * 100)
            }
            update(record: newAnalyzeByMyFighter)
            
            // opponentFighter
            let opponentGame = records?.filter("opponentFighter == %@", S.fightersArray[i][1])
            let opponentWin = opponentGame?.filter("result == true")
            let newAnalyzeByOpponentFighter = AnalyzeByOpponentFighter()
            
            newAnalyzeByOpponentFighter.opponentFighter = S.fightersArray[i][1]
            newAnalyzeByOpponentFighter.fighterID = i
            
            if let game = opponentGame, let win = opponentWin {
                newAnalyzeByOpponentFighter.game = game.count
                newAnalyzeByOpponentFighter.win = win.count
                newAnalyzeByOpponentFighter.lose = game.count - win.count
                newAnalyzeByOpponentFighter.winRate = Float(CGFloat(win.count) / CGFloat(game.count) * 100)
            }
            update(record: newAnalyzeByOpponentFighter)
            
        }
        
        for i in 0...S.stageArray.count - 1 {
            
            // stage
            let stageGame = records?.filter("stage == %@", S.stageArray[i])
            let stageWin = stageGame?.filter("result == true")
            let newAnalyzeByStage = AnalyzeByStage()
            
            newAnalyzeByStage.stage = S.stageArray[i]
            newAnalyzeByStage.stageID = i
            
            if let game = stageGame, let win = stageWin {
                newAnalyzeByStage.game = game.count
                newAnalyzeByStage.win = win.count
                newAnalyzeByStage.lose = game.count - win.count
                newAnalyzeByStage.winRate = Float(CGFloat(win.count) / CGFloat(game.count) * 100)
            }
            update(record: newAnalyzeByStage)
            
        }
        
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
