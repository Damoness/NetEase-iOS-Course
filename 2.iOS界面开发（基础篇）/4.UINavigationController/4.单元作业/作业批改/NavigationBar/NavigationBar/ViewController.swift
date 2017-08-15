//
//  ViewController.swift
//  NavigationBar
//
//  Created by 胡诚真 on 2017/5/4.
//  Copyright © 2017年 胡诚真. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let searchBar: UISearchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar;
        searchBar.placeholder = "在千万海外商品中搜索"
        if let searchBarField = searchBar .value(forKey: "_searchField") as? UITextField {
            searchBarField.backgroundColor = UIColor(red: 234.0/255, green: 235.0/255, blue: 237.0/255, alpha: 1)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func scan(_ sender: Any) {
        print("scan")
    }
    @IBAction func message(_ sender: Any) {
        print("message")
    }

    @IBAction func tapOnView(_ sender: Any) {
        searchBar.endEditing(true)
    }
}

