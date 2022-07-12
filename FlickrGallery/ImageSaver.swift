//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Wesam Khallaf on 18/05/2022.
//

import UIKit
import AVFAudio
class ImageSaver : NSObject {
    
    
    var successHandler : (()->Void)?
     var errorHandler : (( Error)->Void)?
    
    func writeToPhotoAlbum( image : UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted(_image:didFinishWithError:contextInfo:)), nil)
    }
    
    
    @objc func saveCompleted(_image : UIImage , didFinishWithError  error : Error? , contextInfo : UnsafeRawPointer )
    {
        if let error = error {
            errorHandler?(error)
        }
        
        else {
            successHandler?()
        }
    }
    
    init(s : (()->Void)? , e : (( Error)->Void)?) {
        successHandler = s
        errorHandler = e
    }
   override init() {
        
    }
}
