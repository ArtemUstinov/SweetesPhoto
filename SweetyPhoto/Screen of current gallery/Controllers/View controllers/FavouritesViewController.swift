//
//  BlaViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 26.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var blaText: UILabel!
    @IBOutlet weak var blaImage: UIImageView!
    
    
    
    //MARK: - Public methods:
    var modelPhoto: Photo?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = modelPhoto
        setup(photoModel: item!)
    }
    
    //MARK: - Private properties:
    private func setup(photoModel: Photo) {
        self.blaText.text = photoModel.title
        self.blaImage.image = UIImage(data: photoModel.image!)
    }
    
    deinit {
        print("Delocated: - FavouritesViewController")
    }
}

