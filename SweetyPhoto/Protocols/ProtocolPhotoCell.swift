//
//  ProtocolPhotoCelc.swift
//  SweetyPhoto
//
//  Created by Артём Устинов on 29.10.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import Foundation

protocol ProtocolPhotoCell {
    
    var url: URL { get }
    var title: String { get }
    var localObject: Photo? { get }
}
