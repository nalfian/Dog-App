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
        DogAPI.requestRandomImage(completionHandler: handeRandomImageResponse(imageData:error:))
    }
    
    func handeRandomImageResponse(imageData: DogImage?, error: Error?){
        guard let imageURL = URL(string: imageData?.message ?? "") else{
            return
        }
        DogAPI.requesImageFile(url: imageURL,
                               completionHandler: self.handleImageFileResponse(image: error:) )
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
}

