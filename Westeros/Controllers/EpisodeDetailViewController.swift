//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 27/09/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!
    
    // MARK: - Properties
    let episode: Episode!
    
    // MARK: - Initialization
    init(episode: Episode) {
        self.episode = episode
        
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
        titleLabel.text = episode.title
        imageView.image = episode.season?.image
        
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM-dd-yyyy"
        dateStringFormatter.dateStyle = .medium
        let releaseDate = dateStringFormatter.string(from: episode.issueDate)
        releaseDateLabel.text = releaseDate
        
        summaryLabel.text = episode.summary
        summaryLabel.isEditable = false
        summaryLabel.isSelectable = false
        
        title = "Episode \(episode.number)"
    }

}
