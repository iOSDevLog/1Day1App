//
//  ModelCollectionViewCell.swift
//  StyleTransfer
//
//  Created by ios dev on 2018/7/16.
//  Copyright © 2018年 Oleg Poyaganov. All rights reserved.
//

import UIKit

class ModelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var modelLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        modelImageView.layer.cornerRadius = 8
        modelImageView.layer.masksToBounds = true
    }
}
