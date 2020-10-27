//
//  CurrentPhotoData.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//


struct PhotoData: Codable {
    
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
//    init?(json: [String: Any]) {
//        let id = json["id"] as? Int
//        let title = json["title"] as? String
//        let url = json["url"] as? String
//        let thumbnailUrl = json["thumbnailUrl"] as? String
//        
//        self.id = id
//        self.title = title
//        self.url = url
//        self.thumbnailUrl = thumbnailUrl
//    }
}

//typealias CurrentPhotoData = [PhotoData]

//struct Photos: Codable {
//    let gallery: [PhotoData]
//}
