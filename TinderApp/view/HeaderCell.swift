//
//  HeaderCell.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/19.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInformation(video: Movie) {
        titleLabel.text = video.title
        channelNameLabel.text = video.channelTitle
    }
    
}
