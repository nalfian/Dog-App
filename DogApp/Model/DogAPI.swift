//
//  DogAPI.swift
//  DogApp
//
//  Created by Unknown on 22/08/19.
//  Copyright © 2019 Nalfian. All rights reserved.
//

import Foundation
import UIKit

class DogAPI{
    enum Endpoint {
        case randomImageAllDog
        case randomImageForBreed(String)
        case listAllBreed
        
        var url: URL{
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageAllDog:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreed:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    class func requestAllBreed(completionHandler: @escaping ([String], Error?) -> Void){
        let breedURL = DogAPI.Endpoint.listAllBreed.url
        let task = URLSession.shared.dataTask(with: breedURL) {
            (data, response, error) in
            guard let data = data else{
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedResponse = try!
                decoder.decode(Breed.self, from: data)
            let breeds = breedResponse.message.keys.map({$0})
            completionHandler(breeds, nil)
        }
        task.resume()
    }
    
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> Void){
        let randomImageEndpoint = DogAPI.Endpoint.randomImageAllDog.url
        let task =
            URLSession.shared.dataTask(with: randomImageEndpoint){
                (data, response, error) in
                guard let data = data else {
                    completionHandler(nil, error)
                    return
                }
                let decoder = JSONDecoder()
                let imageData = try!
                    decoder.decode(DogImage.self, from: data)
                completionHandler(imageData, nil)
        }
        task.resume()
    }
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void){
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url
        let task =
            URLSession.shared.dataTask(with: randomImageEndpoint){
                (data, response, error) in
                guard let data = data else {
                    completionHandler(nil, error)
                    return
                }
                let decoder = JSONDecoder()
                let imageData = try!
                    decoder.decode(DogImage.self, from: data)
                completionHandler(imageData, nil)
        }
        task.resume()
    }
    
    class func requesImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void){
        let task = URLSession.shared.dataTask(
            with: url,
            completionHandler: {(data,
                response,
                error) in
                guard let data = data else{
                    completionHandler(nil, error)
                    return
                }
                let downloadImage = UIImage(data: data)
                completionHandler(downloadImage, nil)
        })
        task.resume()
    }
}
