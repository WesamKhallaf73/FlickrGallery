//
//  MyError.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 30/06/2022.
//

import Foundation

enum MyError: Error {
    case parseUrl(String)
    case parseJson(String)
}
