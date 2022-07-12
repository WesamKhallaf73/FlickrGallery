//
//  PhotoInfoView.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 06/07/2022.
//

import SwiftUI
import MapKit

struct PhotoInfoView: View {
    
    @State var photoinfo : PhotoUrlInfos
    @Environment(\.dismiss) var dismiss
    
    var locations : [Location]?
    
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
            
    var body: some View {
        //NavigationView {
        VStack {
           
                            
                                
            VStack {
                ZStack {Color.blue
                    VStack {
                Text("\(photoinfo.title ??   "No title" )")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    //.customized(.blue, .white)
                    Text("location")
                        .font(.caption)
                        HStack {
                            Spacer()
                            Text("Dismiss").padding(5)
                                .background(.red)
                                //.clipShape(Capsule())
                                .shadow(radius: 5)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                       
                    }
                }
                .frame( height: 100)
                
            }
                                
                           
                                if locations != nil {
                                Map(coordinateRegion: $mapRegion , annotationItems: (locations! ) ) {location in

                                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!), tint: .red)
                                }
                                }
        
        }
        
            
                
    }
}
                           
            
        
            //.frame(width: proxy.size.width, height: proxy.size.height)
        
  
//struct PhotoInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoInfoView(photoinfo :  PhotoUrlInfos()
//    }
//}
/*
let id : String  ///??
let owner : String?
let secret : String?
let server : String?
let farm : Int?
let title : String?
let ispublic : Int?
let isfriend : Int?
let isfamily : Int?
*/
