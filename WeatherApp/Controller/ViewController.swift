//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mehmet Ergün on 2022-08-09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       assignBackground()
        
    }

    func assignBackground() {
        let background = UIImage(named: "rain")

                var imageView : UIImageView!
                imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
                imageView.clipsToBounds = true
                imageView.image = background
                imageView.center = view.center
                view.addSubview(imageView)
                self.view.sendSubviewToBack(imageView)
    }

}

