//
//  DetailView-ViewModel.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 01/07/2022.
//

import SwiftUI

@MainActor
class DetailViewModel : ObservableObject {
    
    @Published var  main : FlickrDataOfGetSize?
    @Published var  main2 : GetLocationFlickrData?
    var networkServer : NetworkServer<FlickrDataOfGetSize>?
    var networkServer2 : NetworkServer<GetLocationFlickrData>?
    @Published var loadingState : LoadingStates = .loading
    
    var photoId : String = ""
    
    @Published var urlsForImageWithDifferntSizes : [String] = []
    
    
     
    init(photoid: String) {
        photoId = photoid
        
        
        
        
    }
    
    func getJsonObject() async throws {
        
        networkServer = NetworkServer (baseUrl: "https://api.flickr.com/services/rest/?&method=flickr.photos.getSizes",
                                          parms: ["api_key" : K.flickrKey , "nojsoncallback" : "1"  ,"format"  : "json"  , "photo_id" : photoId ],
                                          method: "flickr.photos.getSizes",
                                          requiredKey: "photo_id")
        networkServer2 = NetworkServer (baseUrl: "https://api.flickr.com/services/rest/?&flickr.photos.geo.getLocation",
                                          parms: ["api_key" : K.flickrKey , "nojsoncallback" : "1"  ,"format"  : "json"  , "photo_id" : photoId ],
                                          method: "flickr.photos.geo.getLocation",
                                          requiredKey: "photo_id")
        guard networkServer != nil  && networkServer != nil  else {return}
        
        do {
        self.main = try await networkServer?.getJsonData()
            if self.main != nil {
                loadingState = .loaded
//            for a_size in main!.sizes.size {
////                print ("label : \(a_size.label ?? "no label")")
////                print ("url : \(a_size.url ?? "no url")")
////                print ("size.source : \(a_size.source ?? "no source")")
////
//
//            }
                
                
            }
            self.main2 = try await networkServer2?.getJsonData()
            if self.main2 != nil {
                
                print (self.main2?.photo.location.latitude)
                print (self.main2?.photo.location.longitude)
            
                locations.append(self.main2!.photo.location)
            
            }
            else {
               print ("no       longitude              available")
            }
            
        }
        catch {
            print(error)
           
            
          loadingState = .failed
            
            throw MyError.parseJson("Could not decode JSON objectt from data")
            
        }
    
        
    }
    
    

    var locations : [Location] = []
        
    

    
}
