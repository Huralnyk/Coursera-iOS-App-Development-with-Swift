import Foundation

// Abstract class
public class Filter
{
    public init() {
        
    }
    
    func formula(pixel: Pixel) -> Pixel {
        return pixel
    }
}

// Abstract class
public class AdjustableFilter : Filter
{
    var minimumTreshold: Double
    var maximumTreshold: Double
    
    var modifier: Double {
        didSet {
            modifier = max(min(maximumTreshold, modifier), minimumTreshold)
        }
    }
    
    required public init(modifier: Double) {
        self.minimumTreshold = 0
        self.maximumTreshold = 0
        self.modifier = modifier
    }
}

public class GrayScale : Filter
{
    override func formula(var pixel: Pixel) -> Pixel {
        let intensity = UInt8(0.299 * Double(pixel.red) + 0.587 * Double(pixel.green) + 0.114 * Double(pixel.blue))
        pixel.red = intensity
        pixel.green = intensity
        pixel.blue = intensity
        return pixel
    }
}

public class Sepia : Filter
{
    override func formula(var pixel: Pixel) -> Pixel {
        let r = Double(pixel.red) * 0.393 + Double(pixel.green) * 0.769 + Double(pixel.blue) * 0.189
        let g = Double(pixel.red) * 0.349 + Double(pixel.green) * 0.686 + Double(pixel.blue) * 0.168
        let b = Double(pixel.red) * 0.272 + Double(pixel.green) * 0.534 + Double(pixel.blue) * 0.131
        
        pixel.red = UInt8(max(0, min(255, r)))
        pixel.green = UInt8(max(0, min(255, g)))
        pixel.blue = UInt8(max(0, min(255, b)))
        return pixel
    }
}

public class Brightness : AdjustableFilter
{
    required public init(modifier: Double) {
        super.init(modifier: modifier)
        self.minimumTreshold = -255.00
        self.maximumTreshold = 255.00
        self.modifier = modifier
    }
    
    convenience init() {
        self.init(modifier: 0)
    }
    
    override func formula(var pixel: Pixel) -> Pixel {
        let r = Double(pixel.red) + modifier
        let g = Double(pixel.green) + modifier
        let b = Double(pixel.blue) + modifier
        
        pixel.red = UInt8(max(0, min(255, r)))
        pixel.green = UInt8(max(0, min(255, g)))
        pixel.blue = UInt8(max(0, min(255, b)))
        return pixel
    }
}

public class Contrast : AdjustableFilter
{
    var factor: Double {
        return (259 * (modifier + 255)) / (255 * (259 - modifier))
    }
    
    
    
    required public init(modifier: Double) {
        super.init(modifier: modifier)
        self.minimumTreshold = -255.00
        self.maximumTreshold = 255.00
        self.modifier = modifier
    }
    
    convenience init() {
        self.init(modifier: 0)
    }
    
    override func formula(var pixel: Pixel) -> Pixel {
        let r = factor * (Double(pixel.red) - 128) + 128
        let g = factor * (Double(pixel.green) - 128) + 128
        let b = factor * (Double(pixel.blue) - 128) + 128
        
        pixel.red = UInt8(max(0, min(255, r)))
        pixel.green = UInt8(max(0, min(255, g)))
        pixel.blue = UInt8(max(0, min(255, b)))
        return pixel
    }
}

public class Gamma : AdjustableFilter
{
    var gammaCorrection: Double {
        return 1 / modifier
    }
    
    
    
    required public init(modifier: Double) {
        super.init(modifier: modifier)
        self.minimumTreshold = 0.01
        self.maximumTreshold = 7.99
        self.modifier = modifier
    }
    
    convenience init() {
        self.init(modifier: 1)
    }
    
    override func formula(var pixel: Pixel) -> Pixel {
        let r = 255 * pow(Double(pixel.red) / 255, gammaCorrection)
        let g = 255 * pow(Double(pixel.green) / 255, gammaCorrection)
        let b = 255 * pow(Double(pixel.blue) / 255, gammaCorrection)
        
        pixel.red = UInt8(max(0, min(255, r)))
        pixel.green = UInt8(max(0, min(255, g)))
        pixel.blue = UInt8(max(0, min(255, b)))
        return pixel
    }
}
