//
//  NetworkPhotoManager.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 24.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import Alamofire

class NetworkPhotoManager {
    
    weak var photosCollectionVC: PhotosCollectionViewController?
    
    var modelOfPhoto = [ModelOfPhoto]()
    var url = "https://jsonplaceholder.typicode.com/photos"
    
    
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
    
    
//    func fetchCurrentPhotos() {
//        let urlString = "https://jsonplaceholder.typicode.com/photos"
//        guard let url = URL(string: urlString) else { return }
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { data, response, error in
//            if let data = data {
//                //                let dataString = String(data: data, encoding: .utf8) else { return }
//                //                            print("OPPPAAAA!")
//                //                            print(dataString)
//                let photoData = self.parseJSON(withData: data)
//            }
//        }
//        task.resume()
//    }
//
//    func parseJSON(withData data: Data) {
//        let decoder = JSONDecoder()
//
//        do {
////            let currentPhotoData = try decoder.decode(CurrentPhotoData.self,
////                                                      from: data)
////            guard let modelOfPhoto = ModelOfPhoto(photoData: PhotoData) else {
////                return nil }
////            print(currentPhotoData)
//
////            return modelOfPhoto
//
////            print(currentPhotoData.title)
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
////        return nil
//    }
    
    
}
