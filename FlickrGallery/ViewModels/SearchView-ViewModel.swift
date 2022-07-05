//
//  ViewModel.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 30/06/2022.
//

import SwiftUI
@MainActor
class ViewModel : ObservableObject {
    
    @Published var  main : FlickrDataOfSearchMethod?
    @Published var networkServer : NetworkServer<FlickrDataOfSearchMethod>?
    
    //@Published var photoSizeInfos : [PhotoSizesInfos] = []
    
    @Published var loadingState : LoadingStates = .loading
    
    var searchTag : String = "Red sea" {didSet {
        Task {
        try? await getJsonObject()
        }
    }
        
    }
     
    init() {
      //  main = try?  await getFlickrData()
    }
    
    
    func getJsonObject() async throws {
        
        print ("called with searchtag \(searchTag)")
       
        
        self.networkServer = NetworkServer (baseUrl: "https://api.flickr.com/services/rest/?&method=flickr.photos.search",
                                          parms: ["api_key" : K.flickrKey , "nojsoncallback" : "1"  ,"format"  : "json"  , "tags" : searchTag ],
                                          method: "flickr.photos.search",
                                          requiredKey: "tags")
        guard networkServer != nil else {return}
        do {
        self.main = try await networkServer?.getJsonData()
            if self.main != nil {
                loadingState = .loaded
            }
            
        }
        catch {
            print(error)
           
            
           loadingState = .failed
            
            throw MyError.parseJson("Could not decode JSON objectt from data")
            
        }
    
        
    }
    

    
    
    func ImageUrl(from phoToInfo:PhotoUrlInfos ) -> String {
      
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
             
           // UrlsOfDifferentSizesForImage(with: photoId!)
            // return [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_%@.%@", farm, server, photo_id, secret, formatString, fileType];
            urlString  = "https://farm" + String(farm!) + ".static.flickr.com/"
            urlString +=  String(server!) + "/" + String(photoId) + "_" + String(secret!) + ".jpg"
             
              
          }
          
     return urlString
          
          
          
            
    }
    
    
    
    
    
}

           


