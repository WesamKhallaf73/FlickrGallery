//
//  FlickrDataOfgetSizeIMethod.swift
//  ImageGallery
//
//  Created by wesam Khallaf on 5/15/20.
//  Copyright © 2020 wesam Khallaf. All rights reserved.
//

struct FlickrDataOfGetSize : Codable {
    let sizes : MainSize
}
struct MainSize : Codable {
    let canblog : Int
    let canprint : Int
    let candownload : Int
    let size : [PhotoSizesInfos]
}
struct PhotoSizesInfos : Codable {
    let label : String?
    let width : Int?
    let height : Int?
    let source : String?
    let url : String?
    let media : String?
}
