//
//  ContentView.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 30/06/2022.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var vm  = ViewModel()
    @State private var showGridView = true
    @State private var searchField : String = ""
    @State private var hidePhotosdetail = false
    
    
    var layOut = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Text("Loading .....!")
                    .padding()
                    .background(vm.loadingState == .failed  ? .red : vm.loadingState == .loading ?  .secondary  : .green  )
                    .clipShape(Capsule())
                    .opacity(vm.loadingState == .loaded ? 0.0 : 1)
                    .animation(.easeInOut(duration: 3), value:vm.loadingState )
        VStack {
            
            HStack {
            TextField("Search for ..", text: $searchField ).padding()
                    .foregroundColor(.secondary)
                Button ("Search") {
                    print("Search for .. \(searchField)")
                    vm.searchTag = searchField
                   // Task {
                       // try await vm.getFlickrData()
                       // if vm.networkServer
                      //  try await vm.networkServer?.getJsonData()
                   // }
                    
                }
            }.padding( .horizontal)
            Spacer()
          
        Group {
            
            if vm.main != nil {
                
                Group {
                    
                    if (vm.main?.photos.photo.count != 0 ) {
                
                ScrollView {
                    Group {
                        if showGridView {
                
                    showGrid
                    }
                        else {
                            showList
                        }
                    }
            }
                }
                    else {
                        Text("Oops ...!! no photos")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            .background(.red)
                            .padding()
                        
                    }
                }
            
            }
        
           
                
        }
        
        }
            
        }.navigationTitle(vm.searchTag)
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            .task {
               // try? await vm.getFlickrData()
                try? await vm.getJsonObject()
                searchField = vm.searchTag
                
            }
            
            
            .toolbar(content: {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(showGridView ? "List" : "Grid") {
                        showGridView.toggle()
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(hidePhotosdetail ? "Show detail" : "Hide info") {
                        hidePhotosdetail.toggle()
                    }
                }
            })
        
        }
            
    }

    
    func imageView(photoInfo : PhotoUrlInfos) -> some View {
        CacheAsyncImage(url: URL(string: vm.ImageUrl(from: photoInfo))! , scale: 3) {   phase  in
            
            
            
            VStack {
                if let image = phase.image {

                    image
                        .resizable()
                        
                        .aspectRatio( contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                    
                        .contextMenu{
                            Button  {
                                vm.saveImageToPhotoAlbum(image)
                                
                                
                            }label: {
                                Label("Save to Photo Album" , systemImage: "tray.and.arrow.down.fill")
                                  
                            }
                            Button {
                              //  backgroundColor = .green
                                vm.addToFeaturedList(photoInfo: photoInfo)
                            }label: {
                                Label("Save to featured list" , systemImage: "star.circle.fill")
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
                
                if !hidePhotosdetail  {
                infoView(photoInfo: photoInfo)
                }
                
            }
            
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    
                    .stroke(.lightBackground )
            )
                

            }
                 .customizedframeHeight(showGridView ? true : false)
        
            
            
            
            
            
            
            
       
    }
    
    
    func infoView(photoInfo :PhotoUrlInfos ) -> some View {
        
        VStack{
            Text(photoInfo.title ?? "No title")
                .font(.headline)
                .foregroundColor(.white)
            Text(photoInfo.owner ?? "unkownOwner" )
                .font(.caption)
                .foregroundColor(.white.opacity(0.5))
        }.padding(.vertical)
            .frame(maxWidth : .infinity)
            .background(.lightBackground)
            
        
    }
    
    var showGrid : some View {
        LazyVGrid(columns: layOut) {
            ForEach(vm.main!.photos.photo) { photo  in
                NavigationLink {
                    
                    DetailView(photoInfo: photo) // later implementation
                    
                }label: {
                    
                    imageView(photoInfo: photo)
                     
                     
                     
                }
                
            }
        }.padding([.horizontal , .bottom])
    }
    
    
    var showList : some View {
        
        LazyVStack {
            ForEach(vm.main!.photos.photo) { photo  in
                NavigationLink {
                    
                    DetailView(photoInfo: photo) // later implementation
                    
                }label: {
                    
                    imageView(photoInfo: photo)
                     
                     
                     
                }
                
            }
        }.padding([.horizontal , .bottom])
        
    }
    
    
    
    
    
    
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}



struct CustumFrameHeight  : ViewModifier {
    var fixedheigt = true
    func body(content: Content) -> some View {
        Group {
            if fixedheigt {
        content
            .frame(height : 230)
        }
            else {
                content
            }
        }
    }
    
    

}

extension View {
    
    func customizedframeHeight(_ isfixedHeight : Bool )-> some View {
        modifier(CustumFrameHeight(fixedheigt: isfixedHeight))
    }
    
}
