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
    
    var analyze = Analyze()
    
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
    }
    
    func loadMainFighter() {
    
        mainFighter = realm.objects(MainFighter.self)
        
        // if mainFighter is nil, create MainFighter
        if mainFighter?.count == 0 {
            analyze.createMainFighter()
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
        
        if let mainFighter = mainFighter?[0] {
            
            records = realm.objects(Record.self).filter("myFighter == %@", mainFighter.mainFighter)
            
//
            
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
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StageCell", for: indexPath) as! MainFighterTableViewCell
            
            cell.stageLabel.adjustsFontSizeToFitWidth = true
            cell.stageLabel.text = S.stageArray[indexPath.row]

            return cell
            
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
