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
    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCustomCell()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Characters"
    }

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
    
    // MARK: - Register Cell
    func registerCustomCell() {
        // Siempre que se haga uso de celdas personalizadas, primero se deben registrar
        let nib = UINib(nibName: "SeasonCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SeasonCell.reuseIdentifier)
    }
    
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = model[indexPath.row] as Person
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SeasonCell.reuseIdentifier) as! SeasonCell
        
        // Sincronizar celda (view) y season (model)
        cell.seasonImageView.image = person.image
        cell.titleLabel.text = person.fullName
        cell.subtitleLabel.text = person.alias
        
        return cell
    }
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = model[indexPath.row]
        // Crear el controlador del detalle de esa casa
        let memberDetailViewController = MemberDetailViewController(model: member)
        // Push a la nueva vista (apilar controladores)
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
}
