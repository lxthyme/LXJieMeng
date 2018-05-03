//
//  LXMengDetailVC.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/7.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

class LXMengDetailVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    lazy var table = {
        return Component._tableView()
    }()
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRect.zero
        imgView.isUserInteractionEnabled = true
        let img = UIImage(named: "zyyc_qiugua_message_bg.png")!
        img.stretchableImage(withLeftCapWidth: Int(img.size.width / 2.0), topCapHeight: Int(img.size.height / 2.0))
        imgView.image = img
        return imgView
    }()
    lazy var lab_selected_tip: UILabel = {
        let lab = UILabel()
        lab.frame = CGRect.zero
        lab.text = "您的选择是:"
        return lab
    }()
    lazy var lab_selected_router: UILabel = {
        let lab = UILabel()
        lab.frame = CGRect.zero
        lab.textColor = UIColor(fromHexString: "#e9382b")
        lab.font = LXToolKit.font(size: 30.0)
        let router = "\(UserDefaults.standard.string(forKey: kMengTopCategoryNameUserDefaultsKey) ?? "") > \(UserDefaults.standard.string(forKey: kMengSecondryCategoryNameUserDefaultsKey) ?? "")"
        lab.adjustsFontSizeToFitWidth = true
        lab.text = router
        return lab
    }()
    var snapshotView: UIView?
    var id: Int32?
    var ds = [LXMengInfoType]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self

        ds = LXMengManager.queryMengInfo(id: id!)
        assert(ds.count != 0, "ERROR!")

        
        imgView.addSubview(table)
        imgView.addSubview(lab_selected_tip)
        imgView.addSubview(lab_selected_router)
        self.view.addSubview(imgView)
//        masonry()
//        let mjBottomBanner = MJBanner.register(withAdSpaceID: LXMengApi.dpBanner, position: KMJADBottomPosition)
        //        mjBottomBanner?.delegate = self
//        mjBottomBanner?.show()
    }

}

extension LXMengDetailVC {
    func setup() {
        let title = UserDefaults.standard.value(forKey: kMengSecondryCategoryNameUserDefaultsKey) as? String
        let label = UILabel()
        label.text = title
        label.font = LXToolKit.font(size: 30.0)
        label.textColor = UIColor(fromHexString: "#e9382b")
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: 160, height: 40)
        self.navigationItem.titleView = label

        self.view.backgroundColor = UIColor.white//LXMengUI.bgColor
        table.backgroundColor = UIColor.clear

        var img = UIImage(named: "share.png")
        img = img?.resizedImage(to: CGSize(width: 30, height: 30))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img, style: .done, target: self, action: #selector(btnShareClick))
    }
}
// MARK: - UITableViewDataSource
extension LXMengDetailVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.font = LXToolKit.font(size: 25.0)
            cell?.backgroundColor = UIColor.clear
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = ds.first?.mengName
        snapshotView = cell?.contentView
        return cell!;
    }
}
// MARK: - UITableViewDelegate
extension LXMengDetailVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension LXMengDetailVC {
    override func rotateUpdateMasonry() {
        imgView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(10)
        }
    }
    override func masonry() {
        let edges = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        lab_selected_tip.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(60)
        }
        lab_selected_router.snp.makeConstraints { (make) in
            make.top.equalTo(lab_selected_tip)
            make.left.equalTo(lab_selected_tip.snp.right).offset(8)
            make.right.equalToSuperview().offset(-40).priority(1)
        }
        table.snp.makeConstraints { (make) in
            make.top.equalTo(lab_selected_tip.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(60)
            make.right.bottom.equalToSuperview().offset(-60)
        }
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(edges)
        }
    }
}
// MARK: - Actions
extension LXMengDetailVC {
    func btnShareClick() {
//        let snapshotImg = self.table.snapshot(opaque: false, scale: 0)
        let snapshotImg = UIImage(named: "WechatIMG74.png")
        if !WXApi.isWXAppInstalled() {
            print("尚未安装微信客户端, 请安装后再进行分享操作~")
            return
        }
        let title_t = UserDefaults.standard.value(forKey: kMengSecondryCategoryNameUserDefaultsKey) as? String ?? "NaN"
        var content = ds.first?.mengName ?? "NaN"
        content = content.trimmingCharacters(in: .whitespacesAndNewlines)
        var title = "【周公解梦】\(title_t) - "
        title.append(content)
        let images = [snapshotImg]
        let url = URL(string: "https://itunes.apple.com/us/app/id1229636503")
        let shareDict = NSMutableDictionary()
        shareDict.ssdkSetupShareParams(byText: content, images: images, url: url, title: title, type: .auto)
        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: shareDict) { (state, type, opts, entity, error, end) in
            switch(state) {
            case .begin:
                break
            case .success:
                print("分享成功!")
                break
            case .cancel:
                print("用户取消分享!")
                break
            case .fail:
                print("失败! ERROR:\(error)")
                break
            }
        }
    }
}
