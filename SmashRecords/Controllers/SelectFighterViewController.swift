//
//  SelectFighterViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class SelectFighterViewController: UIViewController {
    
    @IBOutlet var fighterViews: [UIButton]!
    private var count = 0
    var fighterName = ""
    var switchSettingFighterName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // show fighter image
        for view in fighterViews {
            view.setImage(UIImage(named: S.fightersArray[count][1]), for: .normal)
            view.imageEdgeInsets = UIEdgeInsets(top: 150, left: 150, bottom: 150, right: 150)
            count += 1
        }
    }
    
    @IBAction func fighterPressed(_ sender: UIButton) {
        
        let num = sender.tag
        fighterName = S.fightersArray[num][1]
        
        switch switchSettingFighterName {
        case "myFighter":
            let preVC = self.presentingViewController as! RecordFormViewController
            preVC.myFighterView.setImage(UIImage(named: fighterName), for: .normal)
            preVC.myFighterView.imageEdgeInsets = UIEdgeInsets(top: 170, left: 170, bottom: 170, right: 170)
            preVC.myFighter = fighterName
            dismiss(animated: true, completion: nil)
        case "opponentFighter":
            let preVC = self.presentingViewController as! RecordFormViewController
            preVC.opponentFighterView.setImage(UIImage(named: fighterName), for: .normal)
            preVC.opponentFighterView.imageEdgeInsets = UIEdgeInsets(top: 170, left: 170, bottom: 170, right: 170)
            preVC.opponentFighter = fighterName
            dismiss(animated: true, completion: nil)
        default:
            break
        }

    }

}
