//
//  RecordFormViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import RealmSwift

class RecordFormViewController: UIViewController {
    
    private var records: Results<Record>?
    
    let realm = try! Realm()
    
    @IBOutlet weak var myFighterView: UIButton!
    @IBOutlet weak var opponentFighterView: UIButton!
    @IBOutlet var stageButtons: [UIButton]!
    @IBOutlet var resultButtons: [UIButton]!
    @IBOutlet weak var registerButton: UIButton!

    
    var myFighter = "mario"
    var opponentFighter = "mario"
    var stage = "終点"
    var result = true

    override func viewDidLoad() {
        super.viewDidLoad()

        stageButtons[2].titleLabel?.adjustsFontSizeToFitWidth = true
        // 終点 and 勝ち is selected
        onButton(button: stageButtons[0])
        onButton(button: resultButtons[0])
        // round register button
        registerButton.layer.cornerRadius = 20
        // set myFighter and opponentFighter image
        myFighterView.setImage(UIImage(named: myFighter), for: .normal)
        myFighterView.imageEdgeInsets = UIEdgeInsets(top: 170, left: 170, bottom: 170, right: 170)
        opponentFighterView.setImage(UIImage(named: opponentFighter), for: .normal)
        opponentFighterView.imageEdgeInsets = UIEdgeInsets(top: 170, left: 170, bottom: 170, right: 170)
    }
    

    @IBAction func myFighterPressed(_ sender: Any) {
        let selectFighterVC = storyboard?.instantiateViewController(identifier: "SelectFighterViewController") as! SelectFighterViewController
        selectFighterVC.switchSettingFighterName = "myFighter"
        present(selectFighterVC, animated: true, completion: nil)
    }
    
    @IBAction func opponentFighterPressed(_ sender: Any) {
        let selectFighterVC = storyboard?.instantiateViewController(identifier: "SelectFighterViewController") as! SelectFighterViewController
        selectFighterVC.switchSettingFighterName = "opponentFighter"
        present(selectFighterVC, animated: true, completion: nil)
    }
    
    @IBAction func stageButtonPressed(_ sender: UIButton) {
        for button in stageButtons {
            offButton(button: button)
        }
        
        switch sender.tag {
        case 0:
            onButton(button: stageButtons[0])
            stage = S.stageArray[0]
        case 1:
            onButton(button: stageButtons[1])
            stage = S.stageArray[1]
        case 2:
            onButton(button: stageButtons[2])
            stage = S.stageArray[2]
        case 3:
            onButton(button: stageButtons[3])
            stage = S.stageArray[3]
        case 4:
            onButton(button: stageButtons[4])
            stage = S.stageArray[4]
        case 5:
            onButton(button: stageButtons[5])
            stage = S.stageArray[5]
        default:
            break
        }
    }
    
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        for button in resultButtons {
            offButton(button: button)
        }
        switch sender.tag {
        case 0:
            onButton(button: resultButtons[0])
            result = true
        case 1:
            onButton(button: resultButtons[1])
            result = false
        default:
            break
        }
    }
 
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        let newRecord = Record()
        newRecord.date = Date()
        newRecord.myFighter = myFighter
        newRecord.opponentFighter = opponentFighter
        newRecord.stage = stage
        newRecord.result = result
        save(record: newRecord)
        dismiss(animated: true, completion: nil)
    }
    
    func save(record: Record) {
        do {
            try realm.write {
                realm.add(record)
            }
        } catch {
            print("Error saving a record\(error)")
        }
    }
    
}

extension RecordFormViewController {
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }

}
