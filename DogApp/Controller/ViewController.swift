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
                do {
                    let json = try JSONSerialization.jsonObject(with: data,
                                                            options: []) as! [String: Any]
                    let url = json["message"] as! String
                    print(url)
                } catch {
                    print(error)
                }
        }
        task.resume()
    }


}

