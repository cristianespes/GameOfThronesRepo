//
//  HouseCollectionViewCell.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 19/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class HouseCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: self)
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameLabel.text = nil
    }
    
}
