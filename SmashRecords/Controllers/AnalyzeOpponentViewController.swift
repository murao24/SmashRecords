//
//  AnalyzeOpponentViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class AnalyzeOpponentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var changeRecords: [UIButton]!
    @IBOutlet var sortRecords: [UIButton]!
    
    var analyze = Analyze()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 45
        
        analyze.loadVC()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchTopButton(n: 1)
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
    }
    

}

extension AnalyzeOpponentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return S.fightersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnalyzeTableViewCell
        cell.winRateLabel.adjustsFontSizeToFitWidth = true

        cell.fighterLabel.image = UIImage(named: S.fightersArray[indexPath.row][1])?.withAlignmentRectInsets(UIEdgeInsets(top: 110, left: 110, bottom: 110, right: 110))
        
        return cell
    }
    
    
}
