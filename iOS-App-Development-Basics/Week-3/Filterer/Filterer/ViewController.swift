//
//  ViewController.swift
//  Filterer
//
//  Created by Alexey Huralnyk on 11/4/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageToggle: UIButton!
    
    var filteredImage: UIImage?
    
    
    
    
    @IBAction func onImageToggle(sender: UIButton) {
        
        if imageToggle.selected {
            imageView.image = UIImage(named: "sample")!
            imageToggle.selected = false
        } else {
            imageView.image = filteredImage
            imageToggle.selected = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "sample")!
        
        // Process the image!
        
        let rgbaImage = RGBAImage(image: image)!
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.height + x
                var pixel = rgbaImage.pixels[index]
                
                let r = Double(pixel.red) * 0.393 + Double(pixel.green) * 0.769 + Double(pixel.blue) * 0.189
                let g = Double(pixel.red) * 0.349 + Double(pixel.green) * 0.686 + Double(pixel.blue) * 0.168
                let b = Double(pixel.red) * 0.272 + Double(pixel.green) * 0.534 + Double(pixel.blue) * 0.131
                
                pixel.red = UInt8(max(0, min(255, r)))
                pixel.green = UInt8(max(0, min(255, g)))
                pixel.blue = UInt8(max(0, min(255, b)))
                rgbaImage.pixels[index] = pixel
            }
        }
        
        filteredImage = rgbaImage.toUIImage()!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

