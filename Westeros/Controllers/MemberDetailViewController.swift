//
//  MembersDetailViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 25/09/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    // MARK: - Properties
    var model: Person!
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var aliasLabel: UILabel!
    
    // MARK: - Initialization
    init(model: Person) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        syncModelWithView()
    }
    
    func syncModelWithView() {
        nameLabel.text = model.fullName
        personImage.image = model.image
        personImage.contentMode = .scaleAspectFit
        aliasLabel.text = model.alias
        
        title = model.name
    }
    
}
