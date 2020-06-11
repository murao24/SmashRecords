//
//  PageViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var parentVC: TopViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        
        parentVC = self.parent as? TopViewController
    }
    
    
    func getFirst() -> AnalyzeOwnViewController {
        return storyboard!.instantiateViewController(identifier: "OwnViewController") as! AnalyzeOwnViewController
    }
    
    func getSecond() -> AnalyzeOpponentViewController {
        return storyboard!.instantiateViewController(identifier: "OpponentViewController") as! AnalyzeOpponentViewController
    }
    
    func getThird() -> AnalyzeStageViewController {
        return storyboard!.instantiateViewController(identifier: "StageViewController") as! AnalyzeStageViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func switchTopButton(n: Int) {
        
        if let parentVC = parentVC {
            for topButton in parentVC.topButtons {
                offButton(button: topButton)
            }
            onButton(button: parentVC.topButtons[n])
        }

    }

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: AnalyzeStageViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: AnalyzeOpponentViewController.self) {
            return getFirst()
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: AnalyzeOwnViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: AnalyzeOpponentViewController.self) {
            return getThird()
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
        guard completed, let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        
        switch currentVC {
        case is AnalyzeOwnViewController:
            switchTopButton(n: 0)
        case is AnalyzeOpponentViewController:
            switchTopButton(n: 1)
        case is AnalyzeStageViewController:
            switchTopButton(n: 2)
        default:
            break
        }

    }
    
}
