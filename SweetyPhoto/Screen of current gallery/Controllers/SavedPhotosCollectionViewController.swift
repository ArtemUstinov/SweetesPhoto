//
//  SavedPhotosCollectionViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import CoreData

class SavedPhotosCollectionViewController: UICollectionViewController {
    
    //MARK: - properties:
    var data = DataPhoto(dataPhoto: [Photo]())
    
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionView.reloadData()
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
//
//        do {
//            data.dataPhoto = try context.fetch(fetchRequest)
//            print("Zzzzzzzzzzzzzzzz")
//
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
        getUrl()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        
//        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
//        
//        do {
//            data.dataPhoto = try context.fetch(fetchRequest)
//            print("BBbbbbbbbbbbbbbbbbb")
//            //            profile.books = try context.fetch(fetchRequestOfBook)
//            
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
        
        getUrl()
        
        collectionView.reloadData()
    }
    
    func getUrl() {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
        
                let fetchRequest = NSFetchRequest<Photo>(entityName: "Photo")
        
                do {
                    data.dataPhoto = try context.fetch(fetchRequest)
                    print("BBbbbbbbbbbbbbbbbbb")
                    //            profile.books = try context.fetch(fetchRequestOfBook)
        
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
//               var resultsArr:[Card] = []
//               do {
//                   resultsArr = try (mainManagedObjectContext!.fetch(fetchRequest) as! [Card])
//               } catch {
//                   let fetchError = error as NSError
//                   print(fetchError)
//               }

        if data.dataPhoto.count > 0 {
            for x in data.dataPhoto {
           if x.title == title {
                 print("YYYEEEESSSSS")
//                 context.delete(x)
               }
             }
          }
    }
    
//    func getUrl() {
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//                let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
//
//
////        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
////        var result: [Photo] = []
////        result = data.dataPhoto
//
//                    do {
////                        data.dataPhoto = try context.fetch(fetchRequest) as! [Photo]
//                        data.dataPhoto = try context.fetch(fetchRequest)
//                        print("Zzzzzzzzzzzzzzzz")
//
//                    } catch let error as NSError {
//                        print(error.localizedDescription)
//                    }
//
////        if data.dataPhoto.count > 0 {
////            for x in data.dataPhoto {
////                if x.title == title {
////                    context.delete(x)
////                    print("REPEAT \(x.title!)")
////                }
////            }
////        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
////               var resultsArr:[Card] = []
////               do {
////                   resultsArr = try (mainManagedObjectContext!.fetch(fetchRequest) as! [Card])
////               } catch {
////                   let fetchError = error as NSError
////                   print(fetchError)
////               }
//
////        if resultsArr.count > 0 {
////         for x in resultsArr {
////           if x.id == id {
////                 print("already exist")
////                 mainManagedObjectContext.deleteObject(x)
////               }
////             }
////          }
//    }
    
    
//    func getUrl() {
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
//
//                    do {
//                        data.dataPhoto = try context.fetch(fetchRequest)
//                        print("Zzzzzzzzzzzzzzzz")
//
//                    } catch let error as NSError {
//                        print(error.localizedDescription)
//                    }
        
//        var selection: [String] = []
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
//        request.returnsObjectsAsFaults = false
//
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                guard let movieId = data.value(forKey: "title") as? String else {
////                                        context.delete(data) // or however you want to handle this situation
//                    //                    continue
//                    continue
//                }
//                selection.contains(movieId) ? context.delete(data) : selection.append(movieId)
//            }
//            print("SAVAVSVSVSVSVSVSVSV")
//            try context.save()
//            return selection
//        } catch {
//            print("Failed")
//        }
//        return selection
//    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.dataPhoto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! DataCell
        
        cell.backgroundColor = .secondarySystemBackground
        
        
        cell.secondDataLabel.text = data.dataPhoto[indexPath.item].title
        cell.secondimageCell.image = UIImage(data: data.dataPhoto[indexPath.item].url!)
        
        cell.tag = indexPath.item
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showbla" {
            
            guard let blaVC = segue.destination as? BlaViewController else { return }
            guard let cell = sender as? DataCell else { return }
            
            if segue.identifier == "showbla" {
                
                guard let indexPath = (sender as? DataCell)?.tag else { return }
                
                blaVC.textSec = cell.secondDataLabel.text
                //                print(blaVC.textSec?.count)
                blaVC.imageSec = cell.secondimageCell.image
                print("ТИТЛЫ ПЕРЕДАЛИСЬ !!!!")
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

}


extension SavedPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
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
}
