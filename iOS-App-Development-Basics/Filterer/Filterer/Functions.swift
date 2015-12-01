//
//  Functions.swift
//  Filterer
//
//  Created by Alexey Huralnyk on 11/18/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

import UIKit

func rotateImage(image: UIImage) -> UIImage {
    
    if (image.imageOrientation == UIImageOrientation.Up ) {
        return image
    }
    
    UIGraphicsBeginImageContext(image.size)
    
    image.drawInRect(CGRect(origin: CGPoint.zero, size: image.size))
    let copy = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return copy
}