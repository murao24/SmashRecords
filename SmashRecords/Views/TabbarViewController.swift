//
//  TabbarViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/11.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    var analyze = Analyze()
    
    var ActivityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 2 {
            
            ActivityIndicator = UIActivityIndicatorView()
            ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            ActivityIndicator.center = self.view.center
            // クルクルをストップした時に非表示する
            ActivityIndicator.hidesWhenStopped = true
            // 色
            ActivityIndicator.color = .gray
            self.view.addSubview(ActivityIndicator)
            
            ActivityIndicator.startAnimating()
            analyze.analyzeRecord()
            ActivityIndicator.stopAnimating()

        }

    }
    
}
