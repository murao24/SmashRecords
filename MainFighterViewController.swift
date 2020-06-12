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
        
        // create
        analyze.createMainFighter(fighterName: "mario")
        // load
        loadMainFighter()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // set Image to topButton
        customizeMainFighterButton()
    }
    
    
    func customizeMainFighterButton() {
        
        mainFighterButton.layer.masksToBounds = true
        mainFighterButton.layer.borderWidth = 3
        mainFighterButton.layer.borderColor = UIColor.orange.cgColor
        mainFighterButton.layer.cornerRadius = mainFighterButton.frame.size.width / 2
        if let mainFighter = mainFighter?[0]{
            mainFighterButton.setImage(UIImage(named: mainFighter.mainFighter), for: .normal)
            mainFighterButton.imageEdgeInsets = UIEdgeInsets(top: 300, left: 250, bottom: 300, right: 250)
        }

    }
    
    func loadMainFighter() {
        mainFighter = realm.objects(MainFighter.self)
    }
    
    
    @IBAction func mainFighterButtonPressed(_ sender: Any) {
        
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
