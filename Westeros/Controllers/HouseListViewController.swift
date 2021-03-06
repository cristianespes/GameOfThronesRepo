//
//  HouseListViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 17/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

protocol HouseListViewControllerDelegate {
    // Should
    // Will
    // Did
    // El primer parámetro de las funciones del delegate es SIEMPRE el objeto
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [House]
    var delegate: HouseListViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [House]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        title = "Houses"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = true
        tableView.alwaysBounceVertical = true
        
        registerCustomCell()
        
        setupUI()
    }
    
    func setupUI() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.maroon
            ]
        }
    }
    
    func registerCustomCell() {
        // Siempre que se haga uso de celdas personalizadas, primero se deben registrar
        let nib = UINib(nibName: "HouseCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HouseCell.reuseIdentifier)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubrir el item (casa) que tenemos que mostrar
        let house = model[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: HouseCell.reuseIdentifier) as! HouseCell
        
        // Sincronizar celda (view) y casa (model)
        cell.sigilImageView.image = house.sigil.image
        cell.nameLabel.text = house.name
        cell.subnameLabel.text = house.words
        
        // Devolver la celda
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Houses"
    }*/
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Recoger la casa pulsada
        let theHouse = house(at: indexPath.row)
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            // Avisar al delegado
            delegate?.houseListViewController(self, didSelectHouse: theHouse)
            
            // Enviar una notificacion
            let nc = NotificationCenter.default
            let notification = Notification(name: .houseDidChangeNotification, object: self, userInfo: [Constants.houseKey : theHouse, Constants.membersKey: theHouse.sortedMembers])
            // Enviar notificacion
            nc.post(notification)
        } else {
            // Crear el controlador del detalle de esa casa
            let houseDetailViewController = HouseDetailViewController(model: theHouse)
            navigationController?.pushViewController(houseDetailViewController, animated: true)
        }
        
        // Guardamos la última casa
        saveLastSelectedHouse(at: indexPath.row)
    }
    
}

extension HouseListViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        let houseDetailViewController = HouseDetailViewController(model: house)
        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
}

// MARK: - Persistence (UserDefaults)
extension HouseListViewController {
    // Guardar la última casa seleccionada
    func saveLastSelectedHouse(at row: Int) {
        let userDefaults = UserDefaults.standard
        // Lo inserta en el diccionario
        userDefaults.set(row, forKey: Constants.lastHouseKey)
        // Guardar
        userDefaults.synchronize() // Por si acaso
    }
    
    // Recuperar la última casa seleccionada
    func lastSelectedHouse() -> House {
        let userDefaults = UserDefaults.standard
        let row = userDefaults.integer(forKey: Constants.lastHouseKey) // Value 0 by default
        return house(at: row)
    }
    
    func house(at index: Int) -> House {
        return model[index]
    }
}
