//
//  MainFIghterViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/12.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class MainFighterViewController: UIViewController {
    
    let realm = try! Realm()

    var mainFighter: Results<MainFighter>?
    var analyzeByMyFighter: Results<AnalyzeByMyFighter>?
    var records: Results<Record>?
    
    var f: [[Any]] = [[]]
    var s: [[Any]] = [[]]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainFighterButton: UIButton!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var loseLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!

    let sections = ["対戦相手", "ステージ"]
    let numberOfSections = [S.fightersArray.count, S.stageArray.count]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 45
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // load
        loadMainFighter()
        // show data
        showMainFighterTotalRecord()
        // set Image to topButton
        customizeMainFighterButton()
        
        // load mainFighter Record for tableVIew cell
        loadMainFighterRecord()
        // reload
        tableView.reloadData()
    }
    
    func loadMainFighter() {
    
        mainFighter = realm.objects(MainFighter.self)
        
        // if mainFighter is nil, create MainFighter
        if mainFighter?.count == 0 {
            createMainFighter()
            mainFighterButton.setImage(UIImage(named: "mario"), for: .normal)
            mainFighterButton.imageEdgeInsets = UIEdgeInsets(top: 300, left: 250, bottom: 300, right: 250)
        } else {
            if let mainFighter = mainFighter?[0] {
                analyzeByMyFighter = realm.objects(AnalyzeByMyFighter.self).filter("myFighter == %@", mainFighter.mainFighter)
                
                mainFighterButton.setImage(UIImage(named: mainFighter.mainFighter), for: .normal)
                mainFighterButton.imageEdgeInsets = UIEdgeInsets(top: 300, left: 250, bottom: 300, right: 250)
            }
            
        }

    }

    func showMainFighterTotalRecord() {
        
        // show
        if let analyzeByMyFighter = analyzeByMyFighter?[0] {
            if analyzeByMyFighter.game != 0 {
                gameLabel.text = "\(analyzeByMyFighter.game)"
                winLabel.text = "\(analyzeByMyFighter.win)"
                loseLabel.text = "\(analyzeByMyFighter.lose)"
                winRateLabel.text = "\(round(analyzeByMyFighter.winRate * 10) / 10)%"
            } else {
                gameLabel.text = "-"
                winLabel.text = "-"
                loseLabel.text = "-"
                winRateLabel.text = "-"
            }
        }
        
    }
    
    func customizeMainFighterButton() {

        mainFighterButton.layer.masksToBounds = true
        mainFighterButton.layer.borderWidth = 3
        mainFighterButton.layer.borderColor = UIColor.orange.cgColor
        mainFighterButton.layer.cornerRadius = mainFighterButton.frame.size.width / 2

    }
    
    func loadMainFighterRecord() {
        
        f = [[]]
        s = [[]]
        
        var game = 0
        var win = 0

        if let mainFighter = mainFighter?[0].mainFighter {

            // fighters
            for i in 0...S.fightersArray.count - 1 {
                
                // search mainFighter records
                records = realm.objects(Record.self).filter("myFighter == %@", mainFighter)
                // search mainFighter * opponentFighter
                records = records?.filter("opponentFighter == %@", S.fightersArray[i][1])
                if let records = records {
                    game = records.count
                }
                // search win records
                records = records?.filter("result == true")
                if let records = records {
                    win = records.count
                }
                f.append([mainFighter, S.fightersArray[i][1], game, win])

            }
            
            // stages
            for i in 0...S.stageArray.count - 1 {
                
                // search mainFighter records
                records = realm.objects(Record.self).filter("myFighter == %@", mainFighter)
                // search mainFighter * stage
                records = records?.filter("stage == %@", S.stageArray[i])
                if let records = records {
                    game = records.count
                }
                // search win records
                records = records?.filter("result == true")
                if let records = records {
                    win = records.count
                }
                s.append([mainFighter, S.stageArray[i], game, win])
            }

        }

    }
    
    
    // if mainFighter is nil
    func createMainFighter() {
        
        let newMainFighter = MainFighter()
        newMainFighter.mainFighter = "mario"
        newMainFighter.ID = 0
        do {
            try realm.write {
                realm.add(newMainFighter)
            }
        } catch {
            print("Error creating a MainFighter\(error)")
        }
    }
    
    func updateMainFighter(fighterName: String) {
        let newMainFighter = MainFighter()
        newMainFighter.ID = 0
        newMainFighter.mainFighter = fighterName
        save(mainFighter: newMainFighter)
    }
    
    func save(mainFighter: MainFighter) {
        do {
            try realm.write {
                realm.add(mainFighter, update: .modified)
            }
        } catch {
            print("Error saving a mainFighter\(error)")
        }
    }
    
    
    @IBAction func mainFighterButtonPressed(_ sender: Any) {
        
        let selectFighterVC = storyboard?.instantiateViewController(identifier: "SelectFighterViewController") as! SelectFighterViewController
        selectFighterVC.switchSettingFighterName = "mainFighter"
        present(selectFighterVC, animated: true, completion: nil)
 
    }
    

}

extension MainFighterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfSections[section]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .lightGray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainFighterTableViewCell
            
            cell.fighterLabel.image = UIImage(named: S.fightersArray[indexPath.row][1])?.withAlignmentRectInsets(UIEdgeInsets(top: 110, left: 110, bottom: 110, right: 110))
            cell.winRateLabel.adjustsFontSizeToFitWidth = true
            
            let game = f[indexPath.row + 1][2] as! Int
            let win = f[indexPath.row + 1][3] as! Int
            
            if game != 0 {
                let lose = game - win
                let winRate = roundf((Float(win) / Float(game)) * 1000) / 10
                
                cell.gameLabel.text = "\(game)"
                cell.winLabel.text = "\(win)"
                cell.loseLabel.text = "\(lose)"
                cell.winRateLabel.text = "\(winRate)%"
                
            } else {
                cell.gameLabel.text = "-"
                cell.winLabel.text = "-"
                cell.loseLabel.text = "-"
                cell.winRateLabel.text = "-"
            }

            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StageCell", for: indexPath) as! MainFighterTableViewCell
            
            cell.stageLabel.adjustsFontSizeToFitWidth = true
            cell.stageWinRateLabel.adjustsFontSizeToFitWidth = true
            cell.stageLabel.text = S.stageArray[indexPath.row]
            
            let game = s[indexPath.row + 1][2] as! Int
            let win = s[indexPath.row + 1][3] as! Int
            
            if game != 0 {
                let lose = game - win
                let winRate = roundf((Float(win) / Float(game)) * 1000) / 10
                
                cell.stageGameLabel.text = "\(game)"
                cell.stageWinLabel.text = "\(win)"
                cell.stageLoseLabel.text = "\(lose)"
                cell.stageWinRateLabel.text = "\(winRate)%"
                
            } else {
                cell.stageGameLabel.text = "-"
                cell.stageWinLabel.text = "-"
                cell.stageLoseLabel.text = "-"
                cell.stageWinRateLabel.text = "-"
            }

            return cell
            
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
