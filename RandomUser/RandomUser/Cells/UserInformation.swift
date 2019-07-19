//
//  UserInformation.swift
//  RandomUser
//
//  Created by jichenjiang on 2019/7/18.
//  Copyright © 2019 jichenjiang. All rights reserved.
//

import UIKit

class UserInformation: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    
    func setUser(user: UserDetail, index: Int) {
        let picUrl = URL(string: user.picture.thumbnail)
        getImage(from: picUrl!)
        
        picture.layer.borderWidth = 3
        picture.layer.borderColor = UIColor.blue.cgColor
        
        name.text = user.name.first.capitalized + " " + user.name.last.uppercased()
        mail.text = user.email
    }
    
    func getImage(from url: URL) {
        getData(from: url) {data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                self.picture.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
