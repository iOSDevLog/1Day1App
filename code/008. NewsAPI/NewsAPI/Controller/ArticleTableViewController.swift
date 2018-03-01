//
//  ArticleTableViewController.swift
//  NewsAPI
//
//  Created by iOS Dev Log on 2018/3/1.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    var source: Source?
    private var token: NSKeyValueObservation?
    private let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
        
        refreshControl?.addTarget(self, action:  #selector(self.refresh(sender:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let source = source else { return }

        token = NewsAPI.service.observe(\.articles) { _, _ in
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
        refreshControl?.beginRefreshing()
        NewsAPI.service.fetchArticles(for: source)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        token?.invalidate()
        NewsAPI.service.resetArticles()
    }
    
    @objc func refresh(sender:AnyObject) {
        NewsAPI.service.fetchArticles(for: source!)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsAPI.service.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.render(article: NewsAPI.service.articles[indexPath.row], using: formatter)
        
        return cell
    }
}
