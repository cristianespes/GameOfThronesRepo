//
//  MemberListViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 18/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Person]
    
    init(model: [Person]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Characters"
    }

    // MARK: - Lyfe Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(membersDidChange), name: .houseDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja las notificaciones
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func membersDidChange(notification: Notification) {
        // Sacar la información y extraer la casa
        guard let info = notification.userInfo, let members = info[Constants.membersKey] as? [Person] else { return }
        // Actualizar el modelo
        self.model = members
        // Sincronizar modelo - vista
        tableView.reloadData()
        
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        let backItem = UIBarButtonItem()
        backItem.title = navigationItem.title
        navigationItem.backBarButtonItem = backItem
    }
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "PersonCell"
        // Descubir cual es la Person
        let person = model[indexPath.row]
        // Crear la celda (o nos la dan desde caché)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        // Sincronizar modelo-vista (person-cell)
        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = person.alias
        
        return cell!
    }
}

extension MemberListViewController: UITableViewDelegate {
    
}
