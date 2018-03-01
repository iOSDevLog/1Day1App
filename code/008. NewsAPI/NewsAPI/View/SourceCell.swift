//
//  SourceCell.swift
//  NewsAPI
//
//  Created by iOS Dev Log on 2018/3/1.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class SourceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var source: Source? {
        didSet {
            guard let source = source else { return }
            nameLabel.text = source.name
            descLabel.text = source.desc
            categoryLabel.text = source.category.capitalized
            languageLabel.text = source.language.capitalized
            countryLabel.text = source.country.capitalized
            urlLabel.text = source.url
        }
    }
}
