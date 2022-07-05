//
//  FlickrDataOfSearchPhotoMetod.swift
//  ImageGallery
//
//  Created by wesam Khallaf on 5/15/20.
//  Copyright © 2020 wesam Khallaf. All rights reserved.
//

import Foundation
struct FlickrDataOfSearchMethod : Codable  {
    
    //let name:String
    let photos : Main1  // main
    
}

struct Main1 : Codable {
    
    let page : Int  // page number
   let pages : Int  // how many pages
    let perpage : Int   // how many photo per this page
   let total : Int     // total number of photos
    let photo : [PhotoUrlInfos]    // array of photoUrls information
}
struct PhotoUrlInfos : Codable  , Identifiable{
    let id : String  ///??
    let owner : String?
    let secret : String?
    let server : String?
    let farm : Int?
    let title : String?
    let ispublic : Int?
    let isfriend : Int?
    let isfamily : Int?
}
