//
//  SavedPhotosCollectionViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class SavedPhotosCollectionViewController: UICollectionViewController {
    
    var data = DataPhoto(photoData: [Photo]())
    
    weak var photosCollVC: PhotosCollectionViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.reloadData()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
                
                do {
                    data.photoData = try context.fetch(fetchRequest)
                    print("Zzzzzzzzzzzzzzzz")
        //            profile.books = try context.fetch(fetchRequestOfBook)

                } catch let error as NSError {
                    print(error.localizedDescription)
                }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        
        do {
            data.photoData = try context.fetch(fetchRequest)
            print("BBbbbbbbbbbbbbbbbbb")
//            profile.books = try context.fetch(fetchRequestOfBook)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        collectionView.reloadData()
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
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.photoData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! DataCell
    
        cell.backgroundColor = .secondarySystemBackground
        
//        let item = data.photoData[indexPath.item]
//        cell.secondDataLabel.text = item.title
        
//        let url = URL(string: item.url)
//        let data = try? Data(contentsOf: url!)
//        cell.photoCellImage.image = UIImage(data: data!)
        
        
        cell.secondDataLabel.text = data.photoData[indexPath.item].title
        cell.secondimageCell.image = UIImage(data: data.photoData[indexPath.item].url!)
        
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
