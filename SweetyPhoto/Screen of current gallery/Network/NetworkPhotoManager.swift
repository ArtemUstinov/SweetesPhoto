//
//  NetworkPhotoManager.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import Alamofire

class NetworkPhotoManager {
    
    //MARK: - Private properties:
    private var modelOfPhoto = [ModelOfPhoto]()
    private var url = "https://jsonplaceholder.typicode.com/photos"
    
    //MARK: - Public methods:
    func fetchPhotos(completion: @escaping ([ModelOfPhoto]) -> Void) {
        let request = AF.request(url)
        request.validate()
        request.responseDecodable(of: [ModelOfPhoto].self) { (response) in
            guard let photo = response.value else { return }
            self.modelOfPhoto = photo
            print(self.modelOfPhoto)
            completion(photo)
        }
    }
}
