//
//  DataCell.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 26.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class FavouritesCell: UICollectionViewCell {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var secondDataLabel: UILabel!
    @IBOutlet weak var secondimageCell: UIImageView!
    
    //MARK: - Private properties:
    private var savedPhoto = [Photo]()
    
    //MARK: - Public methods:
    func setup(photoModel: Photo) {
        self.secondDataLabel.text = photoModel.title
        self.secondimageCell.image = UIImage(data: photoModel.image!)
    }
}
