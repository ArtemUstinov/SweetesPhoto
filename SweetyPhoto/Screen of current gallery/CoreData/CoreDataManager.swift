//
//  CoreDataManager.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 29.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager {
    
    //MARK: - Public properties:
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SweetyPhoto")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
}
