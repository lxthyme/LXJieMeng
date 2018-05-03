//
//  LXMengSecondCategoryVC.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/6.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"
class LXMengSecondCategoryVC: BaseVC,UITableViewDelegate, UITableViewDataSource {
    lazy var table = {
        return Component._tableView()
    }()
    var id: Int32 = 0
    var ds = [LXMengSecondCategoryType]()
    override func viewDidLoad() {
        setup()
        // Do any additional setup after loading the view.
//        if id != 0 {
            ds = LXMengManager.querySecondCategory(cateID: id)
//        }
        self.title = self.title?.appending("(\(ds.count))")
        table.rowHeight = 100
        table.delegate = self
        table.dataSource = self
        table.register(LXMengSecondCategoryCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(table)
        super.viewDidLoad()
    }
}
extension LXMengSecondCategoryVC {
    func setup() {
        let title = UserDefaults.standard.value(forKey: kMengTopCategoryNameUserDefaultsKey) as? String
        let label = UILabel()
        label.text = title
        label.font = LXToolKit.font(size: 30.0)
        label.textColor = UIColor(fromHexString: "#e9382b")
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: 160, height: 40)
        self.navigationItem.titleView = label
        self.navigationController?.navigationBar.tintColor = UIColor(fromHexString: "#e9382b")

        self.view.backgroundColor = UIColor.white//LXMengUI.bgColor
        table.backgroundColor = LXMengUI.bgColor

//        let mjTopBanner = MJBanner.register(withAdSpaceID: LXMengApi.spBanner, position: KMJADBottomPosition)
        //        mjTopBanner?.delegate = self
//        mjTopBanner?.show()
    }
}
// MARK: - UITableViewDataSource
extension LXMengSecondCategoryVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! LXMengSecondCategoryCell
        cell.selectionStyle = .none
        let item = ds[indexPath.row]
        cell.lab_title.text = item.mengName
        return cell;
    }
}
// MARK: - UITableViewDelegate
extension LXMengSecondCategoryVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)!
        let item = ds[indexPath.row]
        UserDefaults.standard.set(item.mengName, forKey: kMengSecondryCategoryNameUserDefaultsKey)
        let mengDetailVC = LXMengDetailVC()
        mengDetailVC.id = item.id
        let realRect = cell.contentView.convert(cell.contentView.frame, to: self.view)
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: realRect)
        UserDefaults.standard.set(archivedData, forKey: UserDefaultsKey.parentView.rawValue)
        self.navigationController?.pushViewController(mengDetailVC, animated: true)
    }
}
extension LXMengSecondCategoryVC {
    override func rotateUpdateMasonry() {
        table.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(10)
        }
    }
    override func masonry() {
        let edges = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(edges)
        }
    }
}
