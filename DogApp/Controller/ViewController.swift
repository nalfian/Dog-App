//
//  ViewController.swift
//  DogApp
//
//  Created by Unknown on 22/08/19.
//  Copyright © 2019 Nalfian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomImageEndpoint = DogAPI.Endpoint.randomImageAllDog.url
        let task =
            URLSession.shared.dataTask(with: randomImageEndpoint){
                (data, response, error) in
                guard let data = data else {
                    return
                }
                let decoder = JSONDecoder()
                let imageData = try!
                    decoder.decode(DogImage.self, from: data)
                print(imageData)
        }
        task.resume()
    }
    
    
}

