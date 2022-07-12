//
//  FeaturedPhoto.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 12/07/2022.
//

import SwiftUI

struct FeaturedPhoto : Codable  , Equatable {
    static func == (lhs: FeaturedPhoto, rhs: FeaturedPhoto) -> Bool {
        lhs.photoInfo.id == rhs.photoInfo.id
    }
    
   var photoInfo : PhotoUrlInfos
    var url : String
    
    
}

