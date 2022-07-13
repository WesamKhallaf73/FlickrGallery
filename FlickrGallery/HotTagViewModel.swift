//
//  HotTagViewModel.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 12/07/2022.
//

import SwiftUI
@MainActor
class HotTagViewModel : ObservableObject {
    
    @Published var  main : HotTagModel?
    @Published var networkServer : NetworkServer<HotTagModel>?
    
    //@Published var photoSizeInfos : [PhotoSizesInfos] = []
    
    @Published var loadingState : LoadingStates = .loading
    
    var period = "day"
    var count = 40
    
    func getJsonObject() async throws {
        
       // print ("called with searchtag \(searchTag)")
        let parameters = ["api_key" : K.flickrKey , "nojsoncallback" : "1"  ,"format"  : "json" , "period"  : period , "count" : String(count) ]
     
        
        networkServer = NetworkServer (baseUrl: "https://api.flickr.com/services/rest/?&method=flickr.tags.getHotList",
                                       parms: parameters,
                                          method: "flickr.tags.getHotList",
                                          requiredKey: "not exist")
                                        //  requiredKey: "tags")
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
    
    
    func addToFeaturedList(photoInfo : PhotoUrlInfos) {
        var featuredList: [FeaturedPhoto] = []
        let existingFeaturedList : [FeaturedPhoto]?
        existingFeaturedList = FileManager.readFromDocumentDirectory(withFileName: "FeaturedPhotos")
        if existingFeaturedList != nil {
            featuredList = existingFeaturedList!

        }
        featuredList.append(FeaturedPhoto (photoInfo: photoInfo, url: ImageUrl(from: photoInfo)))
        FileManager.writeToDocumentDirectory(data: featuredList, withFileName: "FeaturedPhotos", withProtectionEnabled: true)

    }
    
    
    func saveImageToPhotoAlbum (_ image : Image) {
        
        let imageSaver = ImageSaver {
            print( "photo saved successfully ")
        } e: { e in
            print ("error saving the photo , \(e.localizedDescription)")
        }

        imageSaver.writeToPhotoAlbum(image: image.snapshot())
        
    }
    
    
}
