//
//  GetLocationFlickrData.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 04/07/2022.
//

import SwiftUI
import CoreLocation

struct GetLocationFlickrData : Codable {
    let photo : Main2
}

struct  Main2 : Codable {
   
    let id : String
    let location : Location
    
     
}

struct Location : Codable  , Identifiable  {
    
    let latitude : String
    let longitude :String
    let accuracy : String
    var id : String {
        latitude + longitude
    }
    
}

/*

{"photo":{"id":"52192984450","location":{"latitude":"53.560182","longitude":"-2.686562","accuracy":"14","context":"0","locality":{"_content":"Shevington"},"county":{"_content":"Wigan"},"region":{"_content":"England"},"country":{"_content":"UK"},"neighbourhood":{"_content":"Shevington"}}},"stat":"ok"}
*/
