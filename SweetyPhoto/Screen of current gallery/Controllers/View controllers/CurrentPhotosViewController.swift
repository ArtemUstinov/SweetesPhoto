//
//  CurrentPhotosViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import CoreData
import SDWebImage

class CurrentPhotosViewController: UIViewController {
    
    //MARK: - IBOutlets:
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    //MARK: - Public properties:
    var modelPhoto: PhotoModel?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let model = modelPhoto else { return }
        setup(modelPhoto: model)
    }
    
    //MARK: - Public methods:
    func setup(modelPhoto: PhotoModel) {
        currentLabel.text = modelPhoto.title
        if modelPhoto.localObject != nil {
            guard let data = modelPhoto.localObject?.image, let image = UIImage(data: data) else { return }
            currentImage.image = image
            print("из памяти")
        } else {
            currentImage.sd_setImage(with: modelPhoto.urlBig) { (image, error, _, url) in
                guard error == nil, image != nil, url != nil else { return }
                
                let context = CoreDataManager.shared.context
                guard let entity = NSEntityDescription.entity(forEntityName: "Photo", in: context) else { return }
                let obj = NSManagedObject(entity: entity, insertInto: context)
                
                let photo = obj as! Photo
                photo.image = image!.pngData()
                photo.title = modelPhoto.title
                photo.url = url!.absoluteString
                modelPhoto.localObject = photo
                print("из интернета")
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    deinit {
        print("Delocated: - CurrentPhotosViewController")
    }
}


