//
//  ArticleCell.swift
//  NewsAPI
//
//  Created by iOS Dev Log on 2018/3/1.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var bannerView: UIImageView!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
    
    private var task: URLSessionDataTask?
    
    func render(article: Article, using formatter: DateFormatter) {
        downloadBanner(from: article.imageURL)
        if let published = article.published {
            publishedLabel.text = formatter.string(from: published)
        } else {
            publishedLabel.text = nil
        }
        titleLabel.text = article.title
        snippetLabel.text = article.snippet
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        guard let task = task else { return }
        task.cancel()
    }
    
    private func downloadBanner(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.bannerView.image = UIImage(data: data)
            }
        }
        task.resume()
        self.task = task
    }
}
