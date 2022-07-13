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
    var shape : ShapeTypes = .capsule
   // var clipShap : ShapContent = ShapContent()
    
   
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backGroundColor)
            .clipShape(getShape(shape: shape))
            .shadow(radius: 5)
            .foregroundColor(forGroundColor)
    }
    
    
    func getShape(shape:ShapeTypes) -> some Shape {
        switch shape {
        case .rectangle:
            return AnyShape(Rectangle())
        case .circle:
            return AnyShape(Circle())
        case .capsule:
            return AnyShape(Capsule())

       
        }
    }

    
    

}

enum ShapeTypes {
    case circle , rectangle , capsule
}



struct AnyShape: Shape {
    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }

    private let _path: (CGRect) -> Path
}

extension View  {
    
    func customized(_ backColor : Color , _ forColor:Color ,_  shape :  ShapeTypes = .capsule)-> some View {
        modifier(custumize(backGroundColor: backColor, forGroundColor: forColor  , shape: shape))
    }
    
}



