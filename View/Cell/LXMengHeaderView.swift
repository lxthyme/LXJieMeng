//
//  LXMengHeaderView.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/6.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit
import SnapKit

class LXMengHeaderView: UICollectionReusableView {
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "zgjm_half_screen.jpg")
        return imgView
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imgView)
        masonry()
    }
//    override func prepareForReuse() {
//        <#code#>
//    }
}
extension LXMengHeaderView {
    func masonry() {
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
