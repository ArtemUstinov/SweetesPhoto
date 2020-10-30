//
//  ModelOfPhoto.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 25.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import Foundation

class PhotoModel: ProtocolPhotoCell {
    
    var urlBig: URL
    var url: URL
    var title: String
    var localObject: Photo?
    
    init(urlBig: URL, url: URL, title: String) {
        self.urlBig = urlBig
        self.url = url
        self.title = title
    }
    
    convenience init?(responseModel: ResponsePhotoModel) {
        guard let url = URL(string: responseModel.thumbnailUrl),
            let bigUrl = URL(string: responseModel.url) else {
                return nil
        }
        self.init(urlBig: bigUrl, url: url , title: responseModel.title)
    }
}

