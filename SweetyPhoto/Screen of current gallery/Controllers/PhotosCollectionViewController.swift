//
//  PhotosCollectionViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

//private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController {
    
    var savedPhotosCollVC = SavedPhotosCollectionViewController()
    
    var dataPhoto = DataPhoto(photoData: [Photo]())
    
    let networkPhotoManager = NetworkPhotoManager()
    
    //    var items = [PhotoData]()
    var modelOfPhoto = [ModelOfPhoto]()
    
    var url = "https://jsonplaceholder.typicode.com/photos"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        let request = AF.request("https://jsonplaceholder.typicode.com/photos")
        //        request.validate()
        //        request.responseDecodable(of: [PhotoData].self) { (response) in
        //            guard let photo = response.value else { return }
        //            self.items = photo
        //            print(self.modelOfPhoto)
        //            self.collectionView.reloadData()
        
        //        let request = AF.request("https://jsonplaceholder.typicode.com/photos")
        //        request.validate()
        //        request.responseDecodable(of: [ModelOfPhoto].self) { (response) in
        //            guard let photo = response.value else { return }
        //            self.modelOfPhoto = photo
        //            print(self.modelOfPhoto)
        //            self.collectionView.reloadData()
        //        }
        
        savedPhotosCollVC.photosCollVC = self
        
//        networkPhotoManager.fetchPhotos { (response) in
//            self.modelOfPhoto = response
//            self.collectionView.reloadData()
//        }
        
        //        networkPhotoManager.fetchCurrentPhotos()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    
    func saveUrl(withTitle title: String, withUrl url: Data) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Photo",
                                                      in: context)
            else { return }
        
        let object = Photo(entity: entity, insertInto: context)
//        object.url = url
        object.title = title
        object.url = url
        
        do {
            try context.save()
            dataPhoto.photoData.append(object)
            print("Oooooooooooooooooooooooooooooo")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        //        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //        return 50
        return modelOfPhoto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
        cell.backgroundColor = .secondarySystemBackground
        
        let item = modelOfPhoto[indexPath.item]
        cell.labelOfImage.text = item.title
        
        let url = URL(string: item.thumbnailUrl)
        let data = try? Data(contentsOf: url!)
        cell.photoCellImage.image = UIImage(data: data!)
        
        cell.tag = indexPath.item
        
        
        return cell
        
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        saveUrl(withTitle: <#T##String#>, withUrl: <#T##Data#>)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFullImage" {
            guard let currentPhotosVC = segue.destination as? CurrentPhotosViewController else { return }
            guard let cell = sender as? PhotoCell else { return }
            
            if segue.identifier == "showFullImage" {
                                
                guard let indexPath = (sender as? PhotoCell)?.tag else { return }
                
                let url = URL(string: modelOfPhoto[indexPath].url)
                guard let data = try? Data(contentsOf: url!) else { return }
                
//                var currentPhoto = currentPhotosVC.image
//                currentPhoto = UIImage(data: data)
//                currentPhoto
                
                currentPhotosVC.image = UIImage(data: data)
                currentPhotosVC.text = cell.labelOfImage.text
                
                saveUrl(withTitle: currentPhotosVC.text!, withUrl: data)

            }
            
            //            currentPhotosVC.image = cell.photoCellImage.image
            //            currentPhotosVC.text = cell.labelOfImage.text
        }
    }
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 4
        let paddingWidth = 13 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        16
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        5
    //    }
}
