//
//  PhotoCell.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    weak var photosColl: PhotosCollectionViewController?
    
    //MARK: - IBOutlets:
    @IBOutlet weak var labelOfImage: UILabel!
    @IBOutlet weak var photoCellImage: UIImageView!
    @IBOutlet weak var checkMarkImage: UIImageView!
    
}
