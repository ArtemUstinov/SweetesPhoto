//
//  ModelOfPhoto.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 25.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//


struct ModelOfPhoto: Codable {
    
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
//    var title: [String] = []
//    var url: [String] = []
//    var thumbnailUrl: [String] = []
        
    init?(photoData: PhotoData) {
        id = photoData.id
        title = photoData.title
        url = photoData.url
        thumbnailUrl = photoData.thumbnailUrl
    }
}
