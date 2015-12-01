//: Playground - noun: a place where people can play

import UIKit

var constantString = "Hi"
var str: String? = "Hello, playground"

//str = nil

print(str)

//var counter = 0

for counter in 0..<10 {
    guard counter != 2 else { continue }
    
    if counter != 5 {
        print(counter)
    }
}




var animals = ["chickens", "cows", "ducks"]
animals[1] = "geese"
animals

var cuteness = [
    "chickens": "somewhat",
    "ducks": "cute",
    "geese": "scary"
]

cuteness["ducks"]

for animal in animals {
    cuteness[animal]
}




func indexOf(name species: String, weight: Int = 0) -> Int {
    switch species {
    case "duck": return 0 + weight
    case "human": return 100 + weight
    default: return -100 + weight
    }
}

indexOf(name: "duck", weight: 10)
indexOf(name: "human", weight: 70)
indexOf(name: "cow", weight: 95)




var beautifulImage = [
    [3, 15, 3],
    [26, 3, 4],
    [14, 8, 22]
]


func raiseLowerNumbers(inout inImage image: [[Int]], to number: Int) {
    for i in 0..<image.count {
        for j in 0..<image[i].count {
            if image[i][j] < number {
                image[i][j] = number
            }
        }
    }
}

raiseLowerNumbers(inImage: &beautifulImage, to: 5)
