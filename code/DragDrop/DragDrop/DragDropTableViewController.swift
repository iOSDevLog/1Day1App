//
//  DragDropTableViewController.swift
//  DragDrop
//
//  Created by iOS Dev Log on 2018/3/2.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class DragDropTableViewController: UITableViewController {
    
    var dataSource = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
        
        for i in 1..<100 {
            dataSource.append(String(i))
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = dataSource[indexPath.row]

        return cell
    }

}

extension DragDropTableViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let listItem = dataSource[indexPath.row]
        let provider = NSItemProvider(object: listItem as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: provider)
        return [dragItem]
    }
    
}
