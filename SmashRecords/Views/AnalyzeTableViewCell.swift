//
//  AnalyzeTableViewCell.swift
//  SmashRecords
//
//  Created by 村尾慶伸 on 2020/06/11.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit

class AnalyzeTableViewCell: UITableViewCell {

    @IBOutlet weak var fighterLabel: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var loseLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    
    @IBOutlet weak var stageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
