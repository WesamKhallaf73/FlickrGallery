//
//  DetailView.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 01/07/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    @StateObject var  dVM  : DetailViewModel = DetailViewModel(photoid: "")
    
   @State  var  photoInfo : PhotoUrlInfos
   @State var urlString = ""
    @State var label = ""
    @State var showSheetView = false
    @State var photoSize : PhotoSizesInfos?
  
    
    @GestureState var magnifyBy = 1.0
    @GestureState var lastmagnifyBy = 1.0
    var layOut = [GridItem(.adaptive(minimum: 100))  ]
    
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    
    var magnification: some Gesture {
            MagnificationGesture()
                .updating($magnifyBy) { currentState, gestureState, transaction in
                    gestureState = currentState
                    //lastmagnifyBy = magnifyBy
                   // scaleOfMaginification = magnifyBy
                }.onEnded { gesture in
                   // scaleOfMaginification = magnifyBy
                    
                }
               

        }
    
    
    var image : UIImage?
            
    
    var body: some View {
      
           ZStack {
              
               VStack {
                   
                   if dVM.main != nil
                   {
                   
                
                       
                    
                           if URL(string: urlString) == nil {
                               listOfSizes
                           }
                           else {
                               ZStack {
                               
                                   ScrollView([.horizontal , .vertical]) {
                               imageView(urlString: urlString)
                                       .frame(width:Double(photoSize?.width   ?? 600 ) * magnifyBy   ,  height: Double(photoSize?.height ?? 600) * magnifyBy )
                                   }
                                  
                                   
                                       
                                   .onTapGesture {
                                       urlString = ""
                                    
                                   }
                                  //.scaleEffect(magnifyBy)
                                               .gesture(magnification)

    
                                   
                                   
                                   
                                   
                               
                           
                           }
                               
                               
                               if dVM.main2 != nil  && dVM.locations.count > 0{
                               VStack {
                                   HStack {
                                       Spacer()
                                      
                                       Text("show Location")
                                           .customized(.blue, .white)
                                           .opacity(0.7)
                                           .onTapGesture {
                                               showSheetView = true
                                           }
                                       
                                   }
                               }
                           }
                           }
                           
                       
          
             
                   }
                   if dVM.main2 != nil  && dVM.locations.count > 0{
                      // Text("this photo has geolocation info")
                       
                      // map
                       
                   }
               }
          
        }
         //  .navigationTitle(urlString == "" ? "Sizes" : label)
           .navigationTitle(photoInfo.title ?? "")
         
       .onAppear {
           Task{
               //print("photo id      is..........\(dVM .photoId)")
           dVM .photoId = photoInfo.id
               try await dVM.getJsonObject()
           }
       }
       .sheet(isPresented: $showSheetView , onDismiss: {
           showSheetView = false
       }) {
           if dVM.main2 != nil  && dVM.locations.count > 0 {
               PhotoInfoView(photoinfo: photoInfo , locations: dVM.locations )
           }
           else {
               PhotoInfoView(photoinfo: photoInfo )
           }
       }
   }
    
//    var map : some View {
//        Map(coordinateRegion: $mapRegion , annotationItems: (dVM.locations ) ) {location in
//
//            MapMarker(coordinate: CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!), tint: .red)
//        
//    }
//    }
    
    var listOfSizes : some View {
        
        
      
       // LazyVGrid(columns: layOut)
        ScrollView {
             VStack {
                 ForEach(dVM.main!.sizes.size.sorted(by: { size1, size2 in
                     size1.width! * size1.height! > size2.width! * size2.height!
                 }) , id:\.label) {size in
                
              
               
                    Text("\(size.label ?? "no label")")
                    .customized(.blue, .white)
                    .font(.title)
                    .padding()
                   
              
                
                    .onTapGesture {
                       urlString = urlForLabel( size.label ?? "")
                        label = size.label ?? ""
                        self.photoSize = size
                    }
            
             }
         }
        }
     
        
    }
    
    func urlForLabel(_ label : String) -> String {
        
        guard dVM.main != nil else {return ""}
        for a_Size in dVM.main!.sizes.size {
            if a_Size.label == label {
                return a_Size.source ?? ""
            }
        }
        return ""
        
        
    }
    

    
    
    func imageView(urlString : String) -> some View {
        
      //////    print ("url is  :  \(urlString) ")
        
        guard URL(string: urlString) != nil else { fatalError("error \(urlString)")}
      
       return CacheAsyncImage(url: URL(string:  urlString)! , scale: 3) {   phase  in
            
            
            
            Group {
                if let image = phase.image {
                   

                    image
                    
                       .resizable()
                        
                       .aspectRatio( contentMode: .fill)
                       // .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        //.clipped()
                       // .aspectRatio(1, contentMode: .fit)
                    
                   
                }

                else if phase.error != nil {
                    Text(" There was an error loading the image")

                }
                else {
                    ProgressView()
                       .accessibilityHidden(true)

                }
                
               
                
            }
            
//           // .clipShape(RoundedRectangle(cornerRadius: 10))
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//
//                    .stroke(.lightBackground )
//            )
                

            }
                 //.customizedframeHeight(showGridView ? true : false)
        
            
            
            
            
            
            
            
       
    }
    
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(photoInfo: PhotoUrlInfos(id: "52149201574", owner: "wesam", secret: "ff", server: "", farm: 66, title: "tt", ispublic: 1, isfriend: 2, isfamily: 3))
}
}





/*
 
 
 Map(coordinateRegion: $viewModel.mapRegion , annotationItems: viewModel.locations) {location in
                 // MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .red)
                 
                 
                 
                 MapAnnotation(coordinate: location.coordinate)  {
                     
                     
                     
                     VStack {
                         Image(systemName: "star.circle")
                             .resizable()
                             .foregroundColor(.red)
                             .frame(width: 44, height: 44)
                             .background(.white)
                             .clipShape(Circle())
                         
                         Text(location.name)
                             .font(.body)
                             .fixedSize()
                             .foregroundColor(.black)
                         
                     }.onTapGesture {
                         viewModel.selectedPlace = location
                     }
                     
                     
                 }
                 
             }
             .ignoresSafeArea()
 */
