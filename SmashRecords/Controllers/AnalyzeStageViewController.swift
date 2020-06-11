//
//  AnalyzeStageViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class AnalyzeStageViewController: UIViewController {
    
    let realm = try! Realm()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var changeRecords: [UIButton]!
    @IBOutlet var sortRecords: [UIButton]!
    
    private var analyzeByStages: Results<AnalyzeByStage>?
    
    var analyze = Analyze()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 45
        
        sortRecords[0].titleLabel?.adjustsFontSizeToFitWidth = true
        
        analyze.loadVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchTopButton(n: 2)
        switchSortButton(n: 0)
        loadStageRecord(sortedBy: "stageID", ascending: true)
    }
    
    func switchTopButton(n: Int) {
        for changeRecord in changeRecords {
            offButton(button: changeRecord)
        }
        onButton(button: changeRecords[n])
    }
    
    func switchSortButton(n: Int) {
        for sortRecord in sortRecords {
            offButton(button: sortRecord)
        }
        onButton(button: sortRecords[n])
    }
    
    @IBAction func topButtonPressed(_ sender: UIButton) {
        switchTopButton(n: sender.tag)
        
        switch sender.tag {
        case 0:
            analyze.switchVC(vc: analyze.viewControllers[0])
        case 1:
            analyze.switchVC(vc: analyze.viewControllers[1])
        case 2:
            analyze.switchVC(vc: analyze.viewControllers[2])
        default:
            break
        }
    }
    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        switchSortButton(n: sender.tag)
        
        switch sender.tag {
        case 0:
            loadStageRecord(sortedBy: "stageID", ascending: true)
        case 1:
            loadStageRecord(sortedBy: "game")
        case 2:
            loadStageRecord(sortedBy: "win")
        case 3:
            loadStageRecord(sortedBy: "lose")
        case 4:
            loadStageRecord(sortedBy: "winRate")
        default:
            break
        }
    }
    
    // fetch and sort records
    func loadStageRecord(sortedBy: String, ascending: Bool = false) {
        analyzeByStages = realm.objects(AnalyzeByStage.self)
        analyzeByStages = analyzeByStages?.sorted(byKeyPath: sortedBy, ascending: ascending)
        tableView.reloadData()
    }
    
}

extension AnalyzeStageViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return S.stageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        cell.winRateLabel.adjustsFontSizeToFitWidth = true
        cell.stageLabel.adjustsFontSizeToFitWidth = true

        if let analyzeByStage = analyzeByStages?[indexPath.row] {
            
            cell.stageLabel.text = analyzeByStage.stage
            
            guard analyzeByStage.game != 0 else {
                cell.gameLabel.text = "-"
                cell.winLabel.text = "-"
                cell.loseLabel.text = "-"
                cell.winRateLabel.text = "-"
                return cell
            }

            cell.gameLabel.text = "\(String(analyzeByStage.game))"
            cell.winLabel.text = "\(String(analyzeByStage.win))"
            cell.loseLabel.text = "\(String(analyzeByStage.lose))"
            cell.winRateLabel.text = "\(String(round(analyzeByStage.winRate * 10) / 10))%"

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
