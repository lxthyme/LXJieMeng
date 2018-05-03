//
//  LXMengSecondCategoryCell.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/7.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

class LXMengSecondCategoryCell: UITableViewCell {
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRect.zero
        var img = UIImage(named: "ljms_base_nav_b.png")!
        img = img.resizableImage(withCapInsets: UIEdgeInsets(top: img.size.height / 2.0, left: img.size.width / 2.0, bottom: img.size.height / 2.0 + 1, right: img.size.width / 2.0 + 1), resizingMode: .stretch)
        imgView.image = img
        return imgView
    }()
    lazy var lab_title: UILabel = {
        let lab = UILabel()
        lab.frame = CGRect.zero
        lab.font = LXToolKit.font(size: 30.0)
        lab.textAlignment = .center
        return lab
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor(fromHexString: "#e4ceb3")
        imgView.addSubview(lab_title)
        self.contentView.addSubview(imgView)

        masonry()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension LXMengSecondCategoryCell {
    func masonry() {
        let edge = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        lab_title.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(20)
//            make.centerY.equalToSuperview()
            make.center.equalToSuperview()
        }
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(edge)
        }
    }
}
