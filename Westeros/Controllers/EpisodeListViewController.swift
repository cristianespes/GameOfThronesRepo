//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 27/09/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Initialization
    let episodes: [Episode]
    
    init(episodes: [Episode]) {
        self.episodes = episodes
        
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
        tableView.tableFooterView = UIView()
        
        title = "Episodes"
    }
    
    
    func registerCustomCell() {
        // Siempre que se haga uso de celdas personalizadas, primero se deben registrar
        let nib = UINib(nibName: "SeasonCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SeasonCell.reuseIdentifier)
    }
    
}

extension EpisodeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row] as Episode
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SeasonCell.reuseIdentifier) as! SeasonCell
        
        // Sincronizar celda (view) y season (model)
        cell.seasonImageView.image = episode.season?.image
        cell.titleLabel.text = episode.title
        
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM-dd-yyyy"
        dateStringFormatter.dateStyle = .medium
        let releaseDate = dateStringFormatter.string(from: episode.issueDate)
        cell.subtitleLabel.text = "\(releaseDate)"
        
        // Devolver la celda
        return cell
    }
}

extension EpisodeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row] as Episode
        
        // Crear el controlador del detalle de esa casa
        let episodeDetailViewController = EpisodeDetailViewController(episode: episode)
        
        // Push a la nueva vista (apilar controladores)
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
}
