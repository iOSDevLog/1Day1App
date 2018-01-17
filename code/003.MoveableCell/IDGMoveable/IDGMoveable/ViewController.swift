//
//  ViewController.swift
//  IDGMoveable
//
//  Created by iOS Dev Log on 2018/1/17.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataSource = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<100 {
            dataSource.append(i)
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row].description
        
        return cell
    }
}

extension ViewController: IDLMoveableCellTableViewDataSource {
    func dataSourceArray(in tableView: UITableView) -> [Any] {
        return self.dataSource
    }
    
    func tableView(_ tableView: UITableView, newDataSourceArrayAfterMove newDataSourceArray: [Any]) {
        self.dataSource = newDataSourceArray as! [Int]
    }
}
