//
//  TopViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
      
    @IBOutlet var topButtons: [UIButton]!
    
    var pageViewController: UIPageViewController?
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onButton(button: topButtons[0])
        
        pageViewController = children.first as? UIPageViewController
        
        let ownVC = storyboard?.instantiateViewController(identifier: "OwnViewController") as! AnalyzeOwnViewController
        let opponentVC = storyboard?.instantiateViewController(identifier: "OpponentViewController") as! AnalyzeOpponentViewController
        let stageVC = storyboard?.instantiateViewController(identifier: "StageViewController") as! AnalyzeStageViewController
        
        viewControllers = [ownVC, opponentVC, stageVC]

    }
    
    func switchVC(vc: UIViewController) {
        if let pageViewController = pageViewController {
            pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
    }

    func switchTopButton(n: Int) {
        
        for topButton in topButtons {
            offButton(button: topButton)
        }
        onButton(button: topButtons[n])
        
    }

    @IBAction func topButtonPressed(_ sender: UIButton) {
        switchTopButton(n: sender.tag)
        
        switch sender.tag {
        case 0:
            switchVC(vc: viewControllers[0])
        case 1:
            switchVC(vc: viewControllers[1])
        case 2:
            switchVC(vc: viewControllers[2])
        default:
            break
        }

    }
    
}
