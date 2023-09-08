//
//  UIImageVIew+Download.swift
//  AppFilmes
//
//  Created by user on 10/08/23.
//

import UIKit
extension UIImageView{
    
    
    func downloadImage(path: String){
        let imageURL = URL(string: path)
        URLSession.shared.dataTask(with: .init(url: imageURL!)){data,_,error in
            if error != nil {return}
            
            guard let data else {return}
            
            
            
            DispatchQueue.main.async {
                self.image = UIImage (data: data)
                
            }
            
        }.resume()
        
    }
}
