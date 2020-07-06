//
//  ViewController.swift
//  UrlSession-Ephemeral
//
//  Created by Fikri on 05/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView: UIImageView = {
        let v = UIImageView()
        
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        downloadImage()
    }
    
    private func downloadImage(){
        let path = "https://www.dicoding.com/blog/wp-content/uploads/2017/10/dicoding-logo-square.png"
        
        let url = URL(string: path)
        
        //let url = URL(string:"https://www.dicoding.com/blog/wp-content/uploads/2017/10/dicoding-logo-square.png")
        
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        
        //let session = URLSession(configuration: .ephemeral)
        
        //background
        //let session = URLSession(configuration: .background(withIdentifier: "com.dicoding.background"))
        
        if let response = configuration.urlCache?.cachedResponse(for: URLRequest(url: url!)) {
            print("Use cache image")
            
            imageView.image = UIImage(data: response.data)
        } else {
            print("call image from network")
            
            let downloadTask: URLSessionDataTask = session.dataTask(with: url!) {
                [weak self] data, response, error in
                guard let self = self, let data = data else {return}
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
            
            downloadTask.resume()
        }
    }
}





