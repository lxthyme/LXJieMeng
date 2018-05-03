//
//  LXMengCategoryVC2.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/6.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

let kCollectionCellIdentifier = "CellIdentifier"
let kCollectionHeaderSectionIdentifier = "HeaderSectionIdentifier"
let kCollectionFooterSectionCellIdentifier = "FooterSectionCellIdentifier"

class LXMengCategoryVC2: BaseVC,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var lastSelectedCell: UICollectionViewCell?
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        let itemWidth = (self.view.frame.size.width - 20 * 2) / (UIScreen.main.scale * 1.0)
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.itemSize = itemSize
        flowLayout.estimatedItemSize = itemSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets.zero
        let ov = UIDevice.current.systemVersion as NSString
        if ov.floatValue >= 9.0 {
//            flowLayout.sectionHeadersPinToVisibleBounds = true
//            flowLayout.sectionFootersPinToVisibleBounds = true
        }
        return flowLayout
    }()
    lazy var _collectionView: UICollectionView = {
        let frame = self.view.bounds
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor(fromHexString: "#e4ceb3")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    lazy var ds = {
        return LXMengManager.queryTopCategory()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
}
// MARK: - UICollectionViewDataSource
extension LXMengCategoryVC2 {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ds.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCellIdentifier, for: indexPath) as! LXMengCategoryCell
        let item = ds[indexPath.item]
        let imgName = "zgjm_big_category_\(item.id).png"
        cell.bgImgView.image = UIImage(named: imgName)
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension LXMengCategoryVC2 {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.size.width
        let height = 354.0 * width / 640.0
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionHeaderSectionIdentifier, for: indexPath)
            return headerView
        }
        assert(true, "ERROR")
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //test snapshot
//        let img = self.view.snapshot()
//        let imgView = UIImageView()
//        imgView.frame = self.view.bounds
//        imgView.frame.size = CGSize(width: 300, height: 300)
//        imgView.image = img
//        self.view.addSubview(imgView)
//        return
        let cell = collectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "zgjm_category_btn_f.png")!)
        lastSelectedCell?.backgroundColor = UIColor.clear
        lastSelectedCell = cell
        //
        let item = ds[indexPath.item]
        UserDefaults.standard.set(item.categoryName, forKey: kMengTopCategoryNameUserDefaultsKey)
        //let secondCategoryVC = LXMengSecondCategoryVC()
        let secondCategoryVC = LXSearchController()
        secondCategoryVC.id = item.id
        secondCategoryVC.title = item.categoryName
        var realRect = cell.contentView.convert(cell.contentView.frame, to: self.view)
        realRect.origin.y += 64
        let data = NSKeyedArchiver.archivedData(withRootObject: realRect)
        UserDefaults.standard.set(data, forKey: UserDefaultsKey.parentView.rawValue)
        self.navigationController?.pushViewController(secondCategoryVC, animated: true)
    }
}
/// MARK: - Actions
extension LXMengCategoryVC2 {
    func btnGoSearchClick() {
        self.navigationController?.pushViewController(LXSearchController(), animated: true)
    }
}
/// MARK: - masonry
extension LXMengCategoryVC2 {
    func setup() {
        let label = UILabel()
        label.text = "周公解梦"
        label.font = LXToolKit.font(size: 30.0)
        label.textColor = UIColor(fromHexString: "#e9382b")
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: 160, height: 40)
        self.navigationItem.titleView = label

        self.view.backgroundColor = LXMengUI.bgColor

        //collection view
        self.view.addSubview(_collectionView)
        _collectionView.isScrollEnabled = true
        _collectionView.register(LXMengCategoryCell.classForCoder(), forCellWithReuseIdentifier: kCollectionCellIdentifier)
        _collectionView.register(LXMengHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionHeaderSectionIdentifier)

        // right bar button item for search action
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(btnGoSearchClick))

        //banner in mjadsdk
//        let mjTopBanner = MJBanner.register(withAdSpaceID: LXMengApi.tpBanner, position: KMJADBottomPosition)
        //        mjTopBanner?.delegate = self
//        mjTopBanner?.show()
    }
    override func masonry() {
        _collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 20, bottom: 20, right: 20))
        }
    }
}
