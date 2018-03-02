//
//  DragDropTableViewController.swift
//  DragDrop
//
//  Created by iOS Dev Log on 2018/3/2.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class DragDropTableViewController: UITableViewController {
    
    var dataSource = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1..<100 {
            dataSource.append(i)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = String(dataSource[indexPath.row])

        return cell
    }

}
