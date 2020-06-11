//
//  AnalyzeOwnViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class AnalyzeOwnViewController: UIViewController {
    
    let realm = try! Realm()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var sortRecords: [UIButton]!
    
    private var analyzeByMyFighters: Results<AnalyzeByMyFighter>?

    var analyze = Analyze()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 45

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchSortButton(n: 0)
        loadMyFighterRecord(sortedBy: "fighterID", ascending: true)
    }

    
    func switchSortButton(n: Int) {
        for sortRecord in sortRecords {
            offButton(button: sortRecord)
        }
        onButton(button: sortRecords[n])
    }
    
    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        switchSortButton(n: sender.tag)
        switch sender.tag {
        case 0:
            loadMyFighterRecord(sortedBy: "fighterID", ascending: true)
        case 1:
            loadMyFighterRecord(sortedBy: "game")
        case 2:
            loadMyFighterRecord(sortedBy: "win")
        case 3:
            loadMyFighterRecord(sortedBy: "lose")
        case 4:
            loadMyFighterRecord(sortedBy: "winRate")
        default:
            break
        }
    }
    
    // fetch and sort records
    func loadMyFighterRecord(sortedBy: String, ascending: Bool = false) {
        analyzeByMyFighters = realm.objects(AnalyzeByMyFighter.self)
        analyzeByMyFighters = analyzeByMyFighters?.sorted(byKeyPath: sortedBy, ascending: ascending)
        tableView.reloadData()
    }
    

}

extension AnalyzeOwnViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return S.fightersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        cell.winRateLabel.adjustsFontSizeToFitWidth = true
        
        if let analyzeByMyFighter = analyzeByMyFighters?[indexPath.row] {
            
            cell.fighterLabel.image = UIImage(named: analyzeByMyFighter.myFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 110, left: 110, bottom: 110, right: 110))
            
            guard analyzeByMyFighter.game != 0 else {
                cell.gameLabel.text = "-"
                cell.winLabel.text = "-"
                cell.loseLabel.text = "-"
                cell.winRateLabel.text = "-"
                return cell
            }
            
            cell.gameLabel.text = "\(String(analyzeByMyFighter.game))"
            cell.winLabel.text = "\(String(analyzeByMyFighter.win))"
            cell.loseLabel.text = "\(String(analyzeByMyFighter.lose))"
            cell.winRateLabel.text = "\(String(round(analyzeByMyFighter.winRate * 10) / 10))%"

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
