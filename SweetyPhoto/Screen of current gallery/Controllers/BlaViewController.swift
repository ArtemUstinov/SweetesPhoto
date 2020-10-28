//
//  BlaViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 26.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class BlaViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var blaText: UILabel!
    @IBOutlet weak var blaImage: UIImageView!
    
    //MARK: - Public properties:
    var imageSec: UIImage?
    var textSec: String?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blaImage.image = imageSec
        blaText.text = textSec
    }
    
    deinit {
        print("BlaVC DEINIT!")
    }
}
