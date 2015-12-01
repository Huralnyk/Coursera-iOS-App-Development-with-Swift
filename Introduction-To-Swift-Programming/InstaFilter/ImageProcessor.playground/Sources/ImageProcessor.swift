import Foundation
import UIKit

public class ImageProcessor
{
    private let defaultFilters = [
        "Sepia"             : Sepia(),
        "Grayscale"         : GrayScale(),
        "2x Gamma"          : Gamma(modifier: 2),
        "+64 Contrast"      : Contrast(modifier: 64),
        "-64 Brightness"    : Brightness(modifier: -64)
    ]
    
    public var image: UIImage
    
    public init(image: UIImage) {
        self.image = image
    }
    
    
    // Applies specific fiter to source image
    // and returns filtered image
    public func applyFilter(filter: Filter) -> UIImage {
        let rgbaImage = RGBAImage(image: image)!
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                let pixel = rgbaImage.pixels[index]
                
                rgbaImage.pixels[index] = filter.formula(pixel)
            }
        }
        return rgbaImage.toUIImage()!
    }
    
    
    // Applies array of filters in the order which they
    // are presented in it and returns filtered image
    public func applyPipelineOfFilters(filters: [Filter]) -> UIImage {
        let rgbaImage = RGBAImage(image: image)!
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                
                
                // In order to improve perfomance apply filter from
                // pipeline on each pixel inside the same loop
                for filter in filters {
                    let pixel = rgbaImage.pixels[index]
                    rgbaImage.pixels[index] = filter.formula(pixel)
                }
            }
        }
        return rgbaImage.toUIImage()!
    }
    
    
    // Applies filter with the specific name if it
    // exists in the dictionary of default filters
    public func applyFilterWithName(name: String) -> UIImage {
        
        // If there is filter with such name
        // apply it and return filtered image
        if let filter = defaultFilters[name] {
            return applyFilter(filter)
        }
        
        // In other case return original image
        return image
    }
}