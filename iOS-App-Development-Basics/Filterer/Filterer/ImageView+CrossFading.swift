//
//  ImageView+CrossFading.swift
//  Filterer
//
//  Created by Alexey Huralnyk on 12/1/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(anImage: UIImage, animated: Bool) {
        let imageView = UIImageView(image: image)
        imageView.frame = frame
        imageView.contentMode = contentMode
        image = anImage
        
        if let view = superview where animated {
            view.insertSubview(imageView, aboveSubview: self)
            UIView.animateWithDuration(0.4, animations: {
                imageView.alpha = 0.0
                }) { completed in
                    if completed {
                        imageView.removeFromSuperview()
                    }
            }
        }
    }
}