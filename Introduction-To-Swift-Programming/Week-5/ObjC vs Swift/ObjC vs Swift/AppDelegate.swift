//
//  AppDelegate.swift
//  ObjC vs Swift
//
//  Created by Alexey Huralnyk on 9/29/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func loadStuff() {
        let cities = [
            City(name: "Toronto", population: 3000000),
            City(name: "Voncouver", population: 5)
        ]
    }

}

