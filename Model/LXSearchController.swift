//
//  LXSearchController.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/5/17.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

class LXSearchController: LXMengSecondCategoryVC, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    lazy var searchVC: UISearchController = {
        let searchVC_t = UISearchController(searchResultsController: nil)
        searchVC_t.dimsBackgroundDuringPresentation = false
        searchVC_t.hidesNavigationBarDuringPresentation = false

        searchVC_t.searchBar.placeholder = "请输入关键词..."
        searchVC_t.searchBar.searchBarStyle = .prominent
        searchVC_t.searchBar.showsCancelButton = true
//        searchVC_t.searchBar.showsBookmarkButton = true
//        searchVC_t.searchBar.showsSearchResultsButton = true

        // ScopeBar
//        searchVC_t.searchBar.showsScopeBar = true
//        searchVC_t.searchBar.scopeButtonTitles = ["Bookmark" ,"Scope","ResultsList","Cancel","Search"]

        searchVC_t.searchBar.frame = CGRect(x: 0, y: 0, width: 414, height: 60)
        return searchVC_t
    }()
    lazy var ds_sources: [LXMengSecondCategoryType] = {
        return self.ds
    }()
    var ds_result = [LXMengSecondCategoryType]()
    var current_title: String?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchVC.isActive = false
    }
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        setup()
        table.tableHeaderView = searchVC.searchBar
        self.title = "全部"
        current_title = self.title
        super.viewDidLoad()
    }

}

/// MARK: - UISearchResultsUpdating
extension LXSearchController {
    func updateSearchResults(for searchController: UISearchController) {
        print("searchController:", searchController)

        let keywords = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if keywords == "" || keywords.characters.count <= 0 {
            return
        }
        print("keywords:", keywords)

        //        let predicate = NSPredicate(format: "SELF CONTAINS %@", keywords)
        if ds_result.count > 0 {
            ds_result = []
        }
        ds_result = ds_sources.filter({ (item: LXMengSecondCategoryType) -> Bool in
            let success = item.mengName.contains(keywords)
            if success {
                print("mengName:", item.mengName, "\tsuccess:", success)
            }
            return success
        })
        ds = ds_result
        self.title = current_title?.appending("(\(ds.count))")
        table.reloadData()
        print("ds:\(ds.count)")
    }
}
/// MARK: - UISearchBarDelegate
extension LXSearchController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarBookmarkButtonClicked")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
    }
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarResultsListButtonClicked")
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("selectedScope:\(selectedScope)")
    }
}
/// MARK: - UISearchControllerDelegate
extension LXSearchController {
    func willPresentSearchController(_ searchController: UISearchController) {
        print("willPresentSearchController")
    }
    func didPresentSearchController(_ searchController: UISearchController) {
        print("didPresentSearchController")
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        print("willDismissSearchController")
    }
    func didDismissSearchController(_ searchController: UISearchController) {
        ds = ds_sources
        self.title = current_title?.appending("(\(ds.count))")
        table.reloadData()
        print("didDismissSearchController")
    }
    func presentSearchController(_ searchController: UISearchController) {
        print("presentSearchController")
    }
}
/// MARK: - Actions
extension LXSearchController {
}
extension LXSearchController {
    override func setup() {
        // search bar
        self.definesPresentationContext = true
        searchVC.searchResultsUpdater = self
        searchVC.delegate = self
        searchVC.searchBar.delegate = self
        self.view.addSubview(searchVC.view)

        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(btnTriggleNavigationBarStateClick))
    }
}
