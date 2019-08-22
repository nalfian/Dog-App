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
                
                guard let imageURL = URL(string: imageData.message) else{
                    return
                }
                
                let taskDownload = URLSession.shared.dataTask(
                    with: imageURL,
                    completionHandler: {(data,
                                         response,
                                         error) in
                        guard let data = data else{
                            return
                        }
                        let downloadImage = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.imageView.image = downloadImage
                        }
                        
                })
                taskDownload.resume()
        }
        task.resume()
    }
    
    
}

