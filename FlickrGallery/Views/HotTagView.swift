//
//  HotTagView.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 01/07/2022.
//

import SwiftUI

struct HotTagView: View {
    @StateObject var vm  = HotTagViewModel ()
    @State private var showGridView = false
   // let date
    //@State private var date : Date = Date(timeInterval: -3600 * 24 * 40 , since: .now )
    @State private var hidePhotosdetail = true
   // @State private var showDatePicker = false
    
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
            
          
          
        Group {
            
            if vm.main != nil {
                
            
                    
                if (vm.main?.hottags.tag.count != 0 ) {
                    ZStack {
                        Color.red.ignoresSafeArea()
                
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
            
        }.navigationTitle("HotTags")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            .task {
               // try? await vm.getFlickrData()
                try? await vm.getJsonObject()
                //searchField = vm.searchTag
                
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


    
    var showGrid : some View {
        LazyVGrid(columns: layOut) {
            ForEach(vm.main!.hottags.tag , id :\._content) { tag   in
                NavigationLink {
                    
                    DetailView(photoInfo:tag.thm_data.photos.photo[0] )
                    
                }label: {
                    
                   // imageView(photoInfo: photo)
                    Text(tag._content)
                        .padding()
                        .customized(.blue, .white , .capsule)
                        .font(.headline)
                        .padding()
                     
                     
                     
                }
                
            }
        }.padding([.horizontal , .bottom])
    }
    
    
    var showList : some View {
       
           
        
        LazyVStack {
            ForEach(vm.main!.hottags.tag , id :\._content) { tag   in
                NavigationLink {
                    
                    DetailView(photoInfo:tag.thm_data.photos.photo[0] ) 
                    
                }label: {
                    
                  
                    Text(tag._content)
                        .padding()
                        .customized(.blue, .white , .capsule)
                       .font(.title)
//                        .foregroundColor(.white)
//                        .padding()
                     
                     
                     
                }
                
            }
        }.padding([.horizontal , .bottom])
        
    
    
    
    }
  
    
    
    

}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        HotTagView()
    }
}
