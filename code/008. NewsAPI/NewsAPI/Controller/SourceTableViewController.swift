//
//  SourceTableViewController.swift
//  NewsAPI
//
//  Created by iOS Dev Log on 2018/3/1.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class SourceTableViewController: UITableViewController {
    
    private var token: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = NewsAPI.service.observe(\.sources) { _, _ in
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
        
        refreshControl?.addTarget(self, action:  #selector(self.refresh(sender:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshControl?.beginRefreshing()
        NewsAPI.service.fetchSources()
    }
    
    @objc func refresh(sender:AnyObject) {
        NewsAPI.service.fetchSources()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsAPI.service.sources.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as! SourceCell
        cell.source = NewsAPI.service.sources[indexPath.row]
        
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ArticleTableViewControllerSegue",
        let destination = segue.destination as? ArticleTableViewController,
        let indexPath = tableView.indexPathForSelectedRow
        else { return }
        destination.source = NewsAPI.service.sources[indexPath.row]
    }

}
