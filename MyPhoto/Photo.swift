//
//  Photo.swift
//  MyPhoto
//
//  Created by Dung Nguyen on 12/17/17.
//  Copyright © 2017 Dung Nguyen - s3598776. All rights reserved.
//

import UIKit

class Photo {
    //MARK: Properties
    var photo: UIImage?
    var description: String
    
    init?(photo: UIImage?, description: String) {
        guard description.count > 140 else {
            return nil
        }
        
        self.photo = photo
        self.description = description
    }
    
}
