//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 24/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
}

class SeasonListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [Season]
    var delegate: SeasonListViewControllerDelegate?
        
    // MARK: - Initialization
    init(model: [Season]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        registerCustomCell()
    }
    
    func registerCustomCell() {
        // Siempre que se haga uso de celdas personalizadas, primero se deben registrar
        let nib = UINib(nibName: "SeasonCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SeasonCell.reuseIdentifier)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubrir el item (season) que tenemos que mostrar
        let season = model[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SeasonCell.reuseIdentifier) as! SeasonCell
        
        // Sincronizar celda (view) y season (model)
        cell.seasonImageView.image = season.image
        cell.titleLabel.text = season.name
        
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM-dd-yyyy"
        dateStringFormatter.dateStyle = .medium
        let releaseDate = dateStringFormatter.string(from: season.releaseDate)
        cell.subtitleLabel.text = "\(releaseDate)"
        
        // Devolver la celda
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Seasons"
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = model[indexPath.row]
        
        // Crear el controlador del detalle de esa casa
        let seasonDetailViewController = SeasonDetailViewController(model: season)
        
        // Push a la nueva vista (apilar controladores)
        navigationController?.pushViewController(seasonDetailViewController, animated: true)
        
        delegate?.seasonListViewController(self, didSelectSeason: season)
    }
    
}
