//
//  LXMengCategoryCell.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/6.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit
import SnapKit

class LXMengCategoryCell: UICollectionViewCell {
    lazy var bgImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRect.zero
        return imgView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(bgImgView)
        masonry()
        bgImgView.image = UIImage(named: "zgjm_big_category_1.png")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension LXMengCategoryCell {
    func masonry() {
        bgImgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
