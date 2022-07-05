//
//  NetworkServer.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 03/07/2022.
//

import SwiftUI
@MainActor
struct NetworkServer<T:Codable> {
let baseUrlString : String
    
    var parameters : [String : String]
    let methodUrl : String
    let requiredKeyName : String

    init (baseUrl : String , parms :  [String : String] , method : String , requiredKey:String )
 {
    baseUrlString = baseUrl
     parameters = parms
     methodUrl = method
     requiredKeyName = requiredKey
    
}



func getJsonData() async throws -> T?   {
    
   guard requiredKeyName != "" else {
       return nil
   }
    
   
    var compositeUrl = URLComponents(string: baseUrlString)!
    let methodQuery  = URLQueryItem(name: "method", value: methodUrl)
  
    compositeUrl.queryItems?.append(methodQuery)
    for (key , value) in  parameters{
        print ("key : \(key) , value : \(value)")
        compositeUrl.queryItems?.append(URLQueryItem(name: key, value: value))
    }
    
    //compositeUrl.queryItems = [methodQuery ,formatQuery ,  jsonCallBackQuery , keyQuery, photoIdQuery ]
    print("compositeUrl is \(compositeUrl)")
    guard let url = compositeUrl.url else {
        throw MyError.parseUrl("some message")
        
    }
    
  
    do {
        let (data , _ ) = try await URLSession.shared.data(from: url)
        
     //////   print(NSString.init(data: data, encoding: String.Encoding.utf8.rawValue)!)
        let decoded = try JSONDecoder().decode(T.self  , from : data)
        
        

        return decoded
        
    }
    
    catch {
        
        print(error)
       
        
        //""loadingState = .failed
        
        throw MyError.parseJson("Could not decode JSON objectt from data")
    }
     
    
    
    

}
}
