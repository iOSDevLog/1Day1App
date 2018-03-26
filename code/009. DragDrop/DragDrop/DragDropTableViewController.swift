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
        tableView.dropDelegate = self
        
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

extension DragDropTableViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath
            else { return }
        
        DispatchQueue.main.async { [weak self] in
            tableView.performBatchUpdates({ coordinator.items.forEach { [weak self] (item) in
                guard let sourceIndexPath = item.sourceIndexPath,
                    let `self` = self
                    else { return }
                
                let row = self.dataSource
                    .remove(at: sourceIndexPath.row)
                self.dataSource
                    .insert(row, at: destinationIndexPath.row)
                tableView.moveRow(at: sourceIndexPath,
                                  to: destinationIndexPath)
                }
            }, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: String.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(
            operation: .move,
            intent: .insertAtDestinationIndexPath)
    }
}
