//
//  FeaturedViewViewModel.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 12/07/2022.
//

import SwiftUI
@MainActor
class FeaturedViewViewModel : ObservableObject {
    
   //@Published  var photoUrllInfoList : [FeaturedPhoto] = []
   // @Published var urls : [String] = []
    @Published var featuredPhotos : [FeaturedPhoto] = []
    func loadFeaturedList() {
     
        let featuredPhotoList: [FeaturedPhoto]?
        featuredPhotoList = FileManager.readFromDocumentDirectory(withFileName: "FeaturedPhotos")
       // urls = featuredPhotoList. ?? []
        featuredPhotos = featuredPhotoList ?? []
      
   
        
    }
    
    
    init() {
        loadFeaturedList()
       
    }
    
    
    
    
    
    func imageUrl(from phoToInfo:PhotoUrlInfos ) -> String {
      
        var urlString = ""
         // let fileType = ".jpg"
          let server = phoToInfo.server
          let secret = phoToInfo.secret
          let farm = phoToInfo.farm
          let photoId = phoToInfo.id
          
          if (farm == nil) || (server == nil )  || (secret == nil ) {
              
              // here we can have an alert text block that no data available
            print ("error url")
          }
          else {
             
           
            urlString  = "https://farm" + String(farm!) + ".static.flickr.com/"
            urlString +=  String(server!) + "/" + String(photoId) + "_" + String(secret!) + ".jpg"
             
              
          }
         // print("url for feateared image is \(urlString)")
     return urlString
          
          
          
            
    }
    
    
}
