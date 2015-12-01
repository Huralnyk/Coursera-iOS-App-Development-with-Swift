//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Process the image!

let rgbaImage = RGBAImage(image: image)!

let redAvg = 118
let greenAvg = 98
let blueAvg = 83
let sum = redAvg + greenAvg + blueAvg

for y in 0..<rgbaImage.height {
    for x in 0..<rgbaImage.width {
        let index = y * rgbaImage.height + x
        var pixel = rgbaImage.pixels[index]
        
        var r = Double(pixel.red) * 0.393 + Double(pixel.green) * 0.769 + Double(pixel.blue) * 0.189
        var g = Double(pixel.red) * 0.349 + Double(pixel.green) * 0.686 + Double(pixel.blue) * 0.168
        var b = Double(pixel.red) * 0.272 + Double(pixel.green) * 0.534 + Double(pixel.blue) * 0.131
        
        pixel.red = UInt8(max(0, min(255, r)))
        pixel.green = UInt8(max(0, min(255, g)))
        pixel.blue = UInt8(max(0, min(255, b)))
        rgbaImage.pixels[index] = pixel
    }
}
image
let newImage = rgbaImage.toUIImage()!


