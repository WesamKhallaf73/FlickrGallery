//
//  GetLocationFlickrData.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 04/07/2022.
//

import SwiftUI

struct GetLocationFlickrData : Codable {
    let photo : Main2
}

struct  Main2 : Codable {
   
    let id : String
    let location : Location
}

struct Location : Codable {
    
    let latitude : String
    let longitude :String
    let accuracy : String
}
