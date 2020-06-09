//
//  ContainerViewController.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    
    private var recordVC: RecordViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeButton()
    }
    
    func customizeButton() {
        addButton.layer.cornerRadius = (addButton.frame.size.width) / 2
        addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        addButton.layer.shadowOpacity = 0.5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableVC = segue.destination as? RecordViewController {
            self.recordVC = tableVC
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let recordFormVC = storyboard?.instantiateViewController(identifier: "RecordFormViewController") as! RecordFormViewController
        present(recordFormVC, animated: true, completion: nil)
    }
    

}
