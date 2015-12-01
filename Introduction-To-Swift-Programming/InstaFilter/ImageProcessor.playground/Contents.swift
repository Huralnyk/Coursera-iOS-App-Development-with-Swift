//: Playground - noun: a place where people can play

import UIKit

/******************* Testing *******************/
let image = UIImage(named: "sample")!


/*************** Original Image ****************/

let imageProcessor = ImageProcessor(image: image)
imageProcessor.image


/*************** +64 Contrast ****************/


imageProcessor.applyFilterWithName("+64 Contrast")


/***************** 2x Gamma ******************/


imageProcessor.applyFilterWithName("2x Gamma")


/****************** Sepia ********************/


imageProcessor.applyFilterWithName("Sepia")


/************** -64 Brightness ***************/


imageProcessor.applyFilterWithName("-64 Brightness")


/***************** Grayscale *****************/


imageProcessor.applyFilterWithName("Grayscale")


/************ Pipeline of filters ************/


let pipeline = [
    Brightness(modifier: 50),
    Gamma(modifier: 0.25),
    Contrast(modifier: -42),
    Sepia()
]

imageProcessor.applyPipelineOfFilters(pipeline)
