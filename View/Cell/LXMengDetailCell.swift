//
//  LXMengDetailCell.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/7.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

class LXMengDetailCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
