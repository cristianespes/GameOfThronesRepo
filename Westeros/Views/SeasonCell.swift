//
//  SeasonCell.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 24/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class SeasonCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: self)
    
    // MARK: - Outlets
    
    @IBOutlet weak var seasonImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        seasonImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
}
