//
//  TableViewCell.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/08.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var sumNaleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var uploaderNameLabel: UILabel!
    @IBOutlet weak var viewCountAndUploadDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
