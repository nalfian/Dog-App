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
    enum Endpoint: String {
        case randomImageAllDog = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL{
            return URL(string: self.rawValue)!
        }
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
