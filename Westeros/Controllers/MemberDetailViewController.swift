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
        
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(membersDidChange), name: .houseDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Baja en la notificación
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func membersDidChange(notification: Notification) {
        navigationController?.popViewController(animated: true)
    }
    
    func syncModelWithView() {
        nameLabel.text = model.fullName
        personImage.image = model.image
        personImage.contentMode = .scaleAspectFit
        aliasLabel.text = model.alias
        
        title = model.name
    }
}
