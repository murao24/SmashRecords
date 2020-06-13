//
//  AnalyzeOpponentViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class AnalyzeOpponentViewController: UIViewController {
    
    let realm = try! Realm()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var sortRecords: [UIButton]!
    
    private var analyzeByOpponentFighters: Results<AnalyzeByOpponentFighter>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 45
        
        addUnderLine(button: sortRecords[0])
        loadOpponentFighterRecord(sortedBy: "fighterID", ascending: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switchSortButton(n: 0)
        loadOpponentFighterRecord(sortedBy: "fighterID", ascending: true)
    }
    
    func switchSortButton(n: Int) {
        for sortRecord in sortRecords {
            removeUnderLine(buton: sortRecord)
        }
        addUnderLine(button: sortRecords[n])
    }
    
    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        switchSortButton(n: sender.tag)
        switch sender.tag {
        case 0:
            loadOpponentFighterRecord(sortedBy: "fighterID", ascending: true)
        case 1:
            loadOpponentFighterRecord(sortedBy: "game")
        case 2:
            loadOpponentFighterRecord(sortedBy: "win")
        case 3:
            loadOpponentFighterRecord(sortedBy: "lose")
        case 4:
            loadOpponentFighterRecord(sortedBy: "winRate")
        default:
            break
        }
    }
    
    // fetch and sort records
    func loadOpponentFighterRecord(sortedBy: String, ascending: Bool = false) {
        analyzeByOpponentFighters = realm.objects(AnalyzeByOpponentFighter.self)
        analyzeByOpponentFighters = analyzeByOpponentFighters?.sorted(byKeyPath: sortedBy, ascending: ascending)
        tableView.reloadData()
    }
    

}

extension AnalyzeOpponentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return S.fightersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        cell.winRateLabel.adjustsFontSizeToFitWidth = true

        if let analyzeByOpponentFighter = analyzeByOpponentFighters?[indexPath.row] {
            
            cell.fighterLabel.image = UIImage(named: analyzeByOpponentFighter.opponentFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 110, left: 110, bottom: 110, right: 110))
            
            guard analyzeByOpponentFighter.game != 0 else {
                cell.gameLabel.text = "-"
                cell.winLabel.text = "-"
                cell.loseLabel.text = "-"
                cell.winRateLabel.text = "-"
                return cell
            }
            
            cell.gameLabel.text = "\(analyzeByOpponentFighter.game)"
            cell.winLabel.text = "\(analyzeByOpponentFighter.win)"
            cell.loseLabel.text = "\(analyzeByOpponentFighter.lose)"
            cell.winRateLabel.text = "\(round(analyzeByOpponentFighter.winRate * 10) / 10)%"

        }
        return cell
    }
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
