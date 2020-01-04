//
//  HeaderCell.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/19.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import UIKit

protocol HeaderCellDelegate {
    func goodButtonDidTapped(isLiked: Bool)
}

class HeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var goodButton: ThumbUpButton!
    var delegate: HeaderCellDelegate!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInformation(video: Movie) {
        titleLabel.text = video.title
        channelNameLabel.text = video.channelTitle
    }
    
    @IBAction func goodButtonDidTapped(_ sender: ThumbUpButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        delegate.goodButtonDidTapped(isLiked: sender.isSelected)
    }
    
    
}
