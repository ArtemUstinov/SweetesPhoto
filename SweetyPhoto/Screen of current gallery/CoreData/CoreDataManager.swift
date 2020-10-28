//
//  CoreDataManager.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 27.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    var dataPhoto = DataPhoto(dataPhoto: [Photo]())
    
    //    func saveUrl(withTitle title: String, withUrl url: Data) {
    //
    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //        let context = appDelegate.persistentContainer.viewContext
    //
    //        guard let entity = NSEntityDescription.entity(forEntityName: "Photo",
    //                                                      in: context)
    //            else { return }
    //
    //        let object = Photo(entity: entity, insertInto: context)
    //        //        object.url = url
    //        object.title = title
    //        object.url = url
    //
    //        do {
    //            try context.save()
    //            dataPhoto.dataPhoto.append(object)
    //            print("Ooooooooooooooooooooooooooooooooo")
    //        } catch let error as NSError {
    //            print(error.localizedDescription)
    //        }
    //    }
    
    func saveUrl(withTitle title: String, withUrl url: Data) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var selection: [Data] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [Photo] {
                guard let movieId = data.value(forKey: "url") as? Data else {
//                    context.delete(data) // or however you want to handle this situation
                    continue
                }
                selection.contains(movieId) ? context.delete(data) : selection.append(movieId)
            }
            print("SAVAVSVSVSVSVSVSVSV")
            try context.save()
        } catch {
            print("Failed")
        }
        //        return selection
    }
}

func getUrl() -> [String] {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
    
    //            do {
    //                dataPhoto.dataPhoto = try context.fetch(fetchRequest)
    //                print("Zzzzzzzzzzzzzzzz")
    //
    //            } catch let error as NSError {
    //                print(error.localizedDescription)
    //            }
    
    var selection: [String] = []
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
    request.returnsObjectsAsFaults = false
    
    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            guard let movieId = data.value(forKey: "title") as? String else {
                //                    context.delete(data) // or however you want to handle this situation
                //                    continue
                continue
            }
            selection.contains(movieId) ? context.delete(data) : selection.append(movieId)
        }
        print("SAVAVSVSVSVSVSVSVSV")
        try context.save()
    } catch {
        print("Failed")
    }
    return selection
}


//    func getUrl() {
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
//
//        do {
//            dataPhoto.dataPhoto = try context.fetch(fetchRequest)
//            print("Zzzzzzzzzzzzzzzz")
//
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }


