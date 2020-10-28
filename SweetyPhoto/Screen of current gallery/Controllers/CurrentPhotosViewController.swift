//
//  CurrentPhotosViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit


class CurrentPhotosViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    //MARK: - Public properties:
    var image: UIImage?
    var checkMark: UIImage?
    var text: String?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentImage.image = image
        currentLabel.text = text
    }
    
    deinit {
        print("Delocated: - CurrentPhotosViewController")
    }
}
