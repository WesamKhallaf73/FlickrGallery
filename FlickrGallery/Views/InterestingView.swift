//
//  InterestingView.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 05/07/2022.
//

import SwiftUI

struct InterestingView: View {
    @StateObject var vm  = InterstingPhotosViewModel ()
    @State private var showGridView = false
   // let date
    @State private var date : Date = Date(timeInterval: -3600 * 24 * 40 , since: .now )
    @State private var hidePhotosdetail = true
    @State private var showDatePicker = false
    
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

               
               if showDatePicker {
               DatePicker(selection: $date, in: ...Date.now , displayedComponents: .date) {
                   Text("select Date")
               }
               }
            
            
           }.padding()
                .foregroundColor(.blue)
          
        Group {
            
            if vm.main != nil {
                
            
                    
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
            
        }.navigationTitle("Interesting")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            .task {
               // try? await vm.getFlickrData()
                try? await vm.getJsonObject()
                //searchField = vm.searchTag
                
            }.onChange(of: date, perform: { newValue in
                Task {
                    vm.searchDate = date
                    try? await vm.getJsonObject()
                }
            })
                .onChange(of: showDatePicker, perform: { newValue in
                    Task {
                        if newValue == false {
                            vm.searchDate = nil
                            
                        }else {
                        vm.searchDate = date
                        try? await vm.getJsonObject()
                        }
                    }
                })
                .onAppear(perform: {
                    Task {
                        vm.searchDate = nil
                    }
                })
               
            
            
            .toolbar(content: {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(showGridView ? "List" : "Grid") {
                        showGridView.toggle()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Toggle(isOn: $showDatePicker) {
                        Text("\(showDatePicker ? "No Specific Date" :"Use date"  )")
                            .font(.body)
                                    
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

struct InterestingView_Previews: PreviewProvider {
    static var previews: some View {
        InterestingView()
    }
}



