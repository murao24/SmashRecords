//
//  RecordTableViewCell.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var myFighterView: UIImageView!
    @IBOutlet weak var opponentFighterView: UIImageView!
    @IBOutlet weak var stageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
