//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 12/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    // Mark: - Properties
    var model: House!
    
    // Mark: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    
    // MARK: - Initialization
    init(model: House) {
        // 1 - Dar valor a las propiedades
        self.model = model
        
        // 2 - Llamar a la superclase
        //super.init(nibName: "HouseDetailViewController", bundle: Bundle.main)
        // Podemos poner nil porque buscará un archivo xib con el mismo nombre que esta clase
        super.init(nibName: nil, bundle: nil)
        
        // 3 - Dar valores a las propiedades de la super clase
        title = model.name
    }
    
    // Chapuza de Apple relacionada con los nil
    // Este init es el que utilizan los StoryBoards
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        
        // Sincronizar modelo y vista
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        houseNameLabel.text = "\(model.name) House"
        sigilImageView.image = model.sigil.image
        sigilImageView.contentMode = .scaleAspectFit
        wordsLabel.text = model.words
        title = model.name
    }
    
    // MARK: - SetupUI
    func setupUI() {
        // Crear un boton
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        // Añadir el botón a la vista
        navigationItem.rightBarButtonItems = [wikiButton, membersButton] // Apareceran de izda a derecha
    }
    
    @objc func displayWiki() {
        // Crear el VC destino
        let wikiViewController = WikiViewController(model: model)
        
        // Navegar a el, push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    
    @objc func displayMembers() {
        let memberListViewController = MemberListViewController(model: model.sortedMembers)
        navigationController?.pushViewController(memberListViewController, animated: true)
    }
    
}

extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
    
    
}
