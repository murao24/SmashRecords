//
//  RecordViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class RecordViewController: UIViewController {
    
    let realm = try! Realm()
    
    private var records: Results<Record>?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        loadRecord()

        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // load record
    func loadRecord() {
        records = realm.objects(Record.self).sorted(byKeyPath: "date", ascending: false)
        tableView.reloadData()
    }

    // delete record
    func deleteRecord(at indexPath: IndexPath) {
        if let record = self.records?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(record)
                }
            } catch {
                print("Error deleting a record \(error)")
            }
        }
    }

}

extension RecordViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordTableViewCell
        
        cell.stageLabel.adjustsFontSizeToFitWidth = true
        
        if let record = records?[indexPath.row] {
            if record.result == true {
                cell.resultLabel.text = "勝ち"
                cell.addBorder(width: 8, color: .orange, position: .left)
            } else {
                cell.resultLabel.text = "負け"
                cell.addBorder(width: 8, color: .systemBlue, position: .left)
            }
            cell.myFighterView.image = UIImage(named: record.myFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 110, left: 110, bottom: 110, right: 110))
            cell.opponentFighterView.image = UIImage(named: record.opponentFighter)?.withAlignmentRectInsets(UIEdgeInsets(top: 110, left: 110, bottom: 110, right: 110))
            cell.stageLabel.text = record.stage
            
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            
            self.deleteRecord(at: indexPath)
            self.tableView.reloadData()
            
            completionHandler(true)
        }
        action.image = UIImage(named: "delete-icon")
        action.backgroundColor = .red
        let configulation = UISwipeActionsConfiguration(actions: [action])
        
        return configulation

        
    }
    

}
