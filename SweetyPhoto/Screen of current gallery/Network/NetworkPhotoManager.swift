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
    private var url = "https://jsonplaceholder.typicode.com/photos"
    
    //MARK: - Public methods:
    func fetchPhotos(completion: @escaping ([ResponsePhotoModel],Error?) -> Void) {
        let request = AF.request(url)
        request.validate()
        request.responseDecodable(of: [ResponsePhotoModel].self) { (response) in
            if let error = response.error {
                completion([],error)
                return
            }
            guard let responseModel = response.value else {
                completion([],nil)
                return }
            completion(responseModel,nil)
        }
    }
}
