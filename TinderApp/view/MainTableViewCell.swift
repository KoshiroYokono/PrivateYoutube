//
//  MainTableViewCell.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/26.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIView.animate(withDuration: 0.3) {
            self.thumbnailImage.alpha = 1.0
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
