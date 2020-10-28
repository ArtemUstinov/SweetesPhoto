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

class PhotosCollectionViewController: UICollectionViewController {
    
    //MARK: - Private properties:
    
    var dataPhoto = DataPhoto(dataPhoto: [Photo]())
    
    let networkPhotoManager = NetworkPhotoManager()
    
    var modelOfPhoto = [ModelOfPhoto]()
    
    var photoCell = PhotoCell()
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        networkPhotoManager.fetchPhotos { (response) in
            self.modelOfPhoto = response
            self.collectionView.reloadData()
        }
        
        
        //        networkPhotoManager.fetchCurrentPhotos()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
    }
    
    
    
    func saveUrl(withTitle title: String, withUrl url: Data, int: Int64, completion: (Bool) -> Void) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Photo",
                                                      in: context)
            else { return }
        
        let object = Photo(entity: entity, insertInto: context)
        //        object.url = url
        object.title = title
        object.url = url
        object.id = int
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        //                   var resultsArr:[Photo] = []
        do {
            //                    if dataPhoto.dataPhoto.count > 0 {
            for x in dataPhoto.dataPhoto {
                if x.url == url {
                    print("already exist \(x.url!)")
                    completion(true)
                    context.delete(x)
                } else {
                    print("ADDDDDDDDD")
                    //                        dataPhoto.dataPhoto.append(x)
                }
            }
            print("END CYCLE")
            //                    }
            dataPhoto.dataPhoto = try context.fetch(fetchRequest) as! [Photo]
            try context.save()
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        //            if resultsArr.count > 0 {
        //             for x in resultsArr {
        //               if x.title == title {
        //                     print("already exist")
        //                     context.delete(x)
        //               } else {
        //                 }
        //              }
        
        //            do {
        //                try context.save()
        //                dataPhoto.dataPhoto.append(object)
        //                print("Ooooooooooooooooooooooooooooooooo")
        //            } catch let error as NSError {
        //                print(error.localizedDescription)
        //            }
        //        }
    }
    //
    //    func saveUrl(withTitle title: String, withUrl url: Data) {
    //
    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //        let context = appDelegate.persistentContainer.viewContext
    //
    //        guard let entity = NSEntityDescription.entity(forEntityName: "Photo",
    //                                                      in: context) else { return }
    //
    //        let object = Photo(entity: entity, insertInto: context)
    //        object.title = title
    //        object.url = url
    //
    //
    //        var selection: [String] = []
    //        let request = NSFetchRequest<NSManagedObject>(entityName: "Photo")
    //        request.returnsObjectsAsFaults = false
    //
    //        let predicate = NSPredicate(format: "title == %@", title)
    //        request.predicate = predicate
    //
    //        do {
    //            let result = try context.fetch(request)
    //            for data in result as! [Photo] {
    //                guard let object = data.value(forKey: "title") as? String else {
    ////                    context.delete(data) // or however you want to handle this situation
    //                    continue
    //                }
    ////                let predicate = NSPredicate(format: "url == %@", url as CVarArg)
    ////                request.predicate = predicate
    //                selection.contains(object) ? context.delete(data) : selection.append(object)
    //            }
    //            print("SAVAVSVSVSVSVSVSVSV")
    //            try context.save()
    //        } catch {
    //            print("Failed")
    //        }
    ////        return selection
    //    }
    
    
    
    //        func saveUrl(withTitle title: String, withUrl url: Data) {
    //
    //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //            let context = appDelegate.persistentContainer.viewContext
    //
    //            guard let entity = NSEntityDescription.entity(forEntityName: "Photo",
    //                                                          in: context) else { return }
    //
    //            let object = Photo(entity: entity, insertInto: context)
    //            object.title = title
    //            object.url = url
    //
    //
    //            var selection: [String] = []
    //            let request = NSFetchRequest<NSManagedObject>(entityName: "Photo")
    //            request.returnsObjectsAsFaults = false
    //
    //            let predicate = NSPredicate(format: "title == %@", title)
    //            request.predicate = predicate
    //
    //            do {
    //                let result = try context.fetch(request)
    //                for data in result as! [Photo] {
    //                    guard let object = data.value(forKey: "title") as? String else {
    //    //                    context.delete(data) // or however you want to handle this situation
    //                        continue
    //                    }
    //    //                let predicate = NSPredicate(format: "url == %@", url as CVarArg)
    //    //                request.predicate = predicate
    //                    selection.contains(object) ? context.delete(data) : selection.append(object)
    //                }
    //                print("SAVAVSVSVSVSVSVSVSV")
    //                try context.save()
    //            } catch {
    //                print("Failed")
    //            }
    //    //        return selection
    //
    //        }
    
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
        
        
        getUrl(index: indexPath, title: modelOfPhoto[indexPath.item].title) { completion in
 
            if completion == true {
                cell.checkMarkImage.isHidden = false
                print("TTTTAAAAAKKK")
            } else {
                cell.checkMarkImage.isHidden = true
            }
        }
        
        //        }
        //            if completion == false {
        //
        //                cell.checkMarkImage.isHidden = false
        //                print("QQQQQQQQ")
        //            } else {
        //                cell.checkMarkImage.isHidden = true
        //            }
        //        }
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFullImage" {
            guard let currentPhotosVC = segue.destination as? CurrentPhotosViewController else { return }
            guard let cell = sender as? PhotoCell else { return }
            
            if segue.identifier == "showFullImage" {
                
                guard let indexPath = (sender as? PhotoCell)?.tag else { return }
                
                guard let url = URL(string: modelOfPhoto[indexPath].url) else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                
                currentPhotosVC.image = UIImage(data: data)
                currentPhotosVC.text = cell.labelOfImage.text
                
                saveUrl(withTitle: currentPhotosVC.text ?? "", withUrl: data, int: Int64(modelOfPhoto[indexPath].id)) {
                    completion in
                    
                    if completion == true {
                        
                        cell.checkMarkImage.isHidden = false
                        print("UUUUUUUUUUU")
                    } else {
                        cell.checkMarkImage.isHidden = true
                    }
                }
            }
            
        }
    }
    
    func getUrl(index: IndexPath, title: String, completion: (Bool) -> Void) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //                    let fetchRequest = NSFetchRequest<Photo>(entityName: "Photo")
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        do {
//            if dataPhoto.dataPhoto[index.item].title == title {
                for x in dataPhoto.dataPhoto {
                    if x.title == title {
                        completion(true)
                        print("CHEEEEEEEEELKKKKKK \(title)")
                    } else {
                        completion(false)
                    }
                }
//            }
            dataPhoto.dataPhoto = try context.fetch(fetchRequest) as! [Photo]
            try context.save()
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
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


