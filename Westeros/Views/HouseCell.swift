//
//  HouseCell.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 19/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class HouseCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: self) // String que se describe a la misma clase

    // MARK: - Outlets
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subnameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sigilImageView.image = nil
        nameLabel.text = nil
        subnameLabel.text = nil
    }
    
}
