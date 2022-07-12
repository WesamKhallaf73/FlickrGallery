//
//  InterstingPhotosViewModel.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 05/07/2022.
//


import SwiftUI
@MainActor
class InterstingPhotosViewModel : ObservableObject {
    
    @Published var  main : InterestingPhotosFlickrData?
    @Published var networkServer : NetworkServer<InterestingPhotosFlickrData>?
    
    //@Published var photoSizeInfos : [PhotoSizesInfos] = []
    
    @Published var loadingState : LoadingStates = .loading
    var  formatter = DateFormatter ()
    
   //Date(timeInterval: -10000000, since: .now)
    var searchDate : Date?  {didSet {
        Task {
        try? await getJsonObject()
        }
    }
        
       
        

    }
     
    init() {
      //  main = try?  await getFlickrData()
    }
    
    
    func getJsonObject() async throws {
        
       // print ("called with searchtag \(searchTag)")
        var parameters = ["api_key" : K.flickrKey , "nojsoncallback" : "1"  ,"format"  : "json"  ]
        if searchDate != nil {
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = NSLocale(localeIdentifier: "EN") as  Locale
            parameters["date"] = formatter.string(from: searchDate!)
            print (parameters["date"]!)
        }
       
        
        networkServer = NetworkServer (baseUrl: "https://api.flickr.com/services/rest/?&method=flickr.interestingness.getList",
                                       parms: parameters,
                                          method: "flickr.interestingness.getList",
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

    
    
    
    
    
    
    
}

           
struct FeaturedPhoto : Codable  {
   var photoInfo : PhotoUrlInfos
    var url : String
    
    
}
