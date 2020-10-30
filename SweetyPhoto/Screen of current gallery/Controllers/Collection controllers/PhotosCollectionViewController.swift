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
import SDWebImage

class PhotosCollectionViewController: UICollectionViewController {
    
    //MARK: - Private properties:
    private let networkPhotoManager = NetworkPhotoManager()
    private var photos: [PhotoModel] = [PhotoModel]()
    private var savedPhoto: [Photo] = [Photo]()
    private var selectedItem: PhotoModel?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCoreDataResult()
        fetchRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        
        photos.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "photoCell",
            for: indexPath) as! PhotoCell
        
        let item = photos[indexPath.item]
        cell.setup(photoModel: item)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! CurrentPhotosViewController
        guard let selectedItem = self.selectedItem else { return }
        destination.modelPhoto = selectedItem
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        
        self.selectedItem = photos[indexPath.item]
        performSegue(withIdentifier: "showCurrent", sender: nil)
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
    
    private func fetchRequest() {
        networkPhotoManager.fetchPhotos { (response,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.photos = response.compactMap { PhotoModel(responseModel: $0) }
            self.checkPhotoInMemory()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func checkPhotoInMemory() {
        for index in 0..<photos.count {
            if let item = savedPhoto.first(where: { (photo) -> Bool in
                return photo.url == photos[index].urlBig.absoluteString
            }) {
                photos[index].localObject = item
            } else {
                photos[index].localObject = nil
            }
        }
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 4
        let paddingWidth = 13 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}


