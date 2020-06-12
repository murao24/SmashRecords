//
//  ToggleButton.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // button toggle
    func onButton(button: UIButton) {
        button.isSelected = true
        button.isEnabled = false
    }
    
    func offButton(button: UIButton) {
        button.isSelected = false
        button.isEnabled = true
    }
    
    func addUnderLine(button: UIButton) {
        button.addBorder(width: 2, color: .systemBlue, position: .bottom)
        button.isEnabled = false
    }
    
    func removeUnderLine(buton: UIButton) {
        
        for layer: CALayer in buton.layer.sublayers! {
            if layer.name == "addBorder" {
                layer.removeFromSuperlayer()
            }
        }

        buton.isEnabled = true
    }
    
}
