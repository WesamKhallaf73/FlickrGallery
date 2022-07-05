//
//  DetailView.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 01/07/2022.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var  dVM  : DetailViewModel = DetailViewModel(photoid: "")
    
   @State  var  photoInfo : PhotoUrlInfos
   @State var urlString = ""
    @State var label = ""
    
    var layOut = [GridItem(.adaptive(minimum: 100))  ]
    
   // var layOut2 = [GridItem(.flexible(minimum: <#T##CGFloat#>, maximum: <#T##CGFloat#>))]
  
    
    var body: some View {
      // ScrollView {
       // NavigationView {
           ZStack {
              // Color.white.ignoresSafeArea()
//               Text("Loading .....!")
//                   .padding()
//                   .background(dVM.loadingState == .failed  ? .red : dVM.loadingState == .loading ?  .secondary  : .green  )
//                   .clipShape(Capsule())
//                   .opacity(dVM.loadingState == .loaded ? 0.0 : 1)
//                   .animation(.easeInOut(duration: 3), value:dVM.loadingState )
//
               Group {
                   
                   if dVM.main != nil
                   {
                   
                  // VStack {
                       
                       Group {
                           if URL(string: urlString) == nil {
                               listOfSizes
                           }
                           else {
                              
                               imageView(urlString: urlString).ignoresSafeArea()
                                       
                                   .onTapGesture {
                                       urlString = ""
                                   }
                               
                           
                           }
                           
                       }
          
             
                   }

           }
        }
           .navigationTitle(urlString == "" ? "Sizes" : label)
         
       .onAppear {
           Task{
               print("photo id      is..........\(dVM .photoId)")
           dVM .photoId = photoInfo.id
               try await dVM.getJsonObject()
           }
       }
   }
    
    var listOfSizes : some View {
        
        
      
       // LazyVGrid(columns: layOut)
        ScrollView {
             VStack {
            ForEach(dVM.main!.sizes.size.reversed() , id:\.label) {size in
                
              
                   // Circle().fill(.red)
                    Text("\(size.label ?? "no label")")
                    .customized(.blue, .white)
                    .font(.title)
                    .padding()
                   // .foregroundColor(.white)
                    //.clipShape(Capsule())
                   // .padding()
                  //  .clipShape(Circle()).background(.red)
              
                
                    .onTapGesture {
                       urlString = urlForLabel( size.label ?? "")
                        label = size.label ?? ""
                    }
            
             }
         }
        }
            // .frame(width: 300, height: .infinity)
        //.foregroundColor(.white)
       // .background(.blue)
        
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
       // let testUrl = "https:\/\/live.staticflickr.com\/65535\/52185835178_ae69632003_o.jpg"

       return CacheAsyncImage(url: URL(string:  urlString)! , scale: 3) {   phase  in
            
            
            
            Group {
                if let image = phase.image {
                   

                    image
                    
                      // .resizable()
                        
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





