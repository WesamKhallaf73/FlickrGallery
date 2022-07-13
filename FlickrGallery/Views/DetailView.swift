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
                
            }.onEnded { gesture in
                // scaleOfMaginification = magnifyBy
                
            }
        
        
    }
    
    
    
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
                            .overlay(
                                Group {
                                    if  dVM.main2 != nil  && dVM.locations.count > 0  { myMapView(locations: dVM.locations)
                                            .onTapGesture {
                                                showSheetView = true
                                                           }
                                                                                    }
                                    else {EmptyView()
                                        
                                                    }
                                   }.frame(width: 60, height: 60)
                                  ,alignment:  .bottomTrailing)
                            
                            
                            
                            
                            
                            
                            .onTapGesture {
                                urlString = ""
                                
                            }
                            
                            .gesture(magnification)
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                }
                
            }
            
        }
        
        .navigationTitle(photoInfo.title ?? "")
        
        .onAppear {
            Task{
                
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
                        .contextMenu{
                            Button  {
                                dVM.saveImageToPhotoAlbum(image)
                                
                                
                            }label: {
                                Label("Save to Photo Album" , systemImage: "tray.and.arrow.down.fill")
                                
                            }
                        }
                    
                    
                    
                }
                
                else if phase.error != nil {
                    Text(" There was an error loading the image")
                    
                }
                else {
                    ProgressView()
                        .accessibilityHidden(true)
                    
                }
                
                
                
            }
            
            
            
            
        }
        
        
        
    }
    
    
    func myMapView(locations : [Location]) ->  some View {
        Map(coordinateRegion: $mapRegion , annotationItems: locations ) {location in
            
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!), tint: .red)
            
            
        }
        
    }
    
    
}




struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(photoInfo: PhotoUrlInfos(id: "52149201574", owner: "wesam", secret: "ff", server: "", farm: 66, title: "tt", ispublic: 1, isfriend: 2, isfamily: 3))
    }
}





