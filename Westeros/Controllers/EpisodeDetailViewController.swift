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
        
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(episodesDidChange), name: .seasonDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja las notificaciones
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func episodesDidChange(notification: Notification) {
        navigationController?.popViewController(animated: true)
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
