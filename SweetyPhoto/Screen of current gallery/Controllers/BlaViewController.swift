//
//  BlaViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 26.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class BlaViewController: UIViewController {
    
    var current = [PhotoData]()
    
    var imageSec: UIImage?
    var textSec: String?

    
    @IBOutlet weak var blaText: UILabel!
    @IBOutlet weak var blaImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blaImage.image = imageSec
        blaText.text = textSec

        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("BlaVC DEINIT!")
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
