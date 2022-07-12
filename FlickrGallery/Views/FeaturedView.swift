//
//  FeaturedView.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 01/07/2022.
//

import SwiftUI


struct FeaturedView: View {
    @StateObject var vm = FeaturedViewViewModel()
    // @State  var photoUrllInfoList : [PhotoUrlInfos]?
    @State private var showGridView = true
    
    @State private var hidePhotosdetail = true
    
    
    var layOut = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationView {
            VStack {
                
                if vm.featuredPhotos.count != 0 {
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
                    Text("No Featured Photos yet ")
                }
                
            }.navigationTitle("Featured Photos")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .onAppear{  vm.loadFeaturedList() }
            
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
        CacheAsyncImage(url: URL(string: vm.imageUrl(from: photoInfo))! , scale: 3) {   phase  in
            
            
            
            VStack {
                if let image = phase.image {
                    
                    image
                        .resizable()
                    
                        .aspectRatio( contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                    
                    
                    
                    
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
        }
        
        
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
            
                .stroke(.lightBackground )
        )
        
        
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
            ForEach(vm.featuredPhotos , id:\.url) {featuredPhoto in
                NavigationLink {
                    
                    DetailView(photoInfo: featuredPhoto.photoInfo)
                    
                }label: {
                    
                    imageView(photoInfo: featuredPhoto.photoInfo)
                    
                    
                    
                }
                
            }
        }.padding([.horizontal , .bottom])
    }
    
    
    var showList : some View {
        
        LazyVStack {
            ForEach(vm.featuredPhotos , id:\.url) {featuredPhoto in
                NavigationLink {
                    
                    DetailView(photoInfo: featuredPhoto.photoInfo)
                    
                }label: {
                    
                    imageView(photoInfo: featuredPhoto.photoInfo)
                    
                    
                    
                }
                
            }
        }.padding([.horizontal , .bottom])
        
    }
    
    
    
    
    
    
    
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView()
    }
}
