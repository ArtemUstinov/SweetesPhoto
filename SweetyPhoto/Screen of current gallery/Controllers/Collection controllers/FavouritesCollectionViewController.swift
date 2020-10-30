//
//  SavedPhotosCollectionViewController.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class FavouritesCollectionViewController: UICollectionViewController {
    
    //MARK: - Private properties:
    var savedPhoto: [Photo] = [Photo]()
    var selectedItem: Photo?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCoreDataResult()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        savedPhoto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! FavouritesCell
        
        let item = savedPhoto[indexPath.item]
        cell.setup(photoModel: item)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedItem = savedPhoto[indexPath.item]
        performSegue(withIdentifier: "showFavourites", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! FavouritesViewController
        guard let selectedItem = self.selectedItem else { return }
        destination.modelPhoto = selectedItem
    }
    
    //MARK: - IBActions:
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        let context = CoreDataManager.shared.context
        do {
            context.delete(selectedItem!)
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Private methods:
    private func getCoreDataResult() {
        
        var results = [Any]()
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        
        do {
            results = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        savedPhoto = results as! [Photo]
    }
}

extension FavouritesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
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
