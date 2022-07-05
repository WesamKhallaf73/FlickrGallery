//
//  CustomViewModifires.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 04/07/2022.
//

import SwiftUI


struct custumize : ViewModifier {
    var backGroundColor : Color
    var forGroundColor : Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backGroundColor)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .foregroundColor(forGroundColor)
    }
    
    

}

extension View {
    
    func customized(_ backColor : Color , _ forColor:Color)-> some View {
        modifier(custumize(backGroundColor: backColor, forGroundColor: forColor))
    }
    
}

