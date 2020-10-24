//
//  CurrentPhotosViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class CurrentPhotosViewController: UIViewController {
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        currentImage.image = image
    }
    
    deinit {
        print("Delocated!!!!")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
