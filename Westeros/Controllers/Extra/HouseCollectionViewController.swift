//
//  HouseCollectionViewController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 19/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class HouseCollectionViewController: UIViewController {
    
    enum Constants {
        static let columns : CGFloat = 2
    }

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "HouseCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: HouseCollectionViewCell.reuseIdentifier)
        }
    }
    
    // MARK: - Properties
    let model : [House]
    let collectionViewLayout: UICollectionViewFlowLayout!
    
    init(model: [House], layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        self.model = model
        self.collectionViewLayout = layout
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        // Asignar el data source
        collectionView.dataSource = self
        
        // Setup del layout
        let width = calculateItemWidth()
        collectionViewLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    func calculateItemWidth() -> CGFloat {
        let viewWidth = view.frame.width
        let spacing = (Constants.columns - 1 ) * collectionViewLayout.minimumLineSpacing // Margen entre items
        let width = (viewWidth - spacing) / Constants.columns
        
        return width
    }

}

extension HouseCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Obtener la casa
        let house = model[indexPath.row]
        
        // Crear (o caché) de una celda
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseCollectionViewCell.reuseIdentifier, for: indexPath) as! HouseCollectionViewCell
        
        // Sync model-view
        cell.imageView.image = house.sigil.image
        cell.nameLabel.text = house.name
        
        // Devolver la celda
        return cell
    }
}
