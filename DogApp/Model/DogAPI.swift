//
//  DogAPI.swift
//  DogApp
//
//  Created by Unknown on 22/08/19.
//  Copyright © 2019 Nalfian. All rights reserved.
//

import Foundation

class DogAPI{
    enum Endpoint: String {
        case randomImageAllDog = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL{
            return URL(string: self.rawValue)!
        }
    }
}
