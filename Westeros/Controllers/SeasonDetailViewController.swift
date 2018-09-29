//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 25/09/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // Mark: - Properties
    var model: Season!
    
    // MARK: - Outlets
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var chaptersLabel: UILabel!
    
    // MARK: - Initialization
    init(model: Season) {
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
        setupUI()
    }
    
    func syncModelWithView() {
        seasonLabel.text = "model.name"
        seasonImage.image = model.image
        
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM-dd-yyyy"
        dateStringFormatter.dateStyle = .medium
        let releaseDate = dateStringFormatter.string(from: model.releaseDate)
        releaseLabel.text = "\(releaseDate)"
        
        chaptersLabel.text = "\(model.count)"
        title = model.name
    }
    
    // MARK: - SetupUI
    func setupUI() {
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        navigationItem.rightBarButtonItem = episodesButton
    }
    
    @objc func displayEpisodes() {
        let episodeListViewController = EpisodeListViewController(episodes: model.sortedEpisodes)
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}

extension SeasonDetailViewController : SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
}
