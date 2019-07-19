//
//  DetailViewController.swift
//  RandomUser
//
//  Created by jichenjiang on 2019/7/18.
//  Copyright © 2019 jichenjiang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var ProfilePhoto: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Mail: UILabel!
    @IBOutlet weak var Mobile: UILabel!
    @IBOutlet weak var Cell: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var City: UILabel!
    @IBOutlet weak var State: UILabel!
    
    var user: UserDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let user = user {
            let picUrl = URL(string: user.picture.large)
            getImage(from: picUrl!)
            Name.text = user.name.title.capitalized + " " + user.name.first.capitalized + " " + user.name.last.uppercased()
            Mail.text = user.email
            Mobile.text = user.phone
            Cell.text = user.cell
            Address.text = user.location.street.capitalized
            City.text = user.location.city.capitalized
            State.text = user.location.state.capitalized
        }
    }
    
    func getImage(from url: URL) {
        getData(from: url) {data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                self.ProfilePhoto.image = UIImage(data: data)
            }
        }
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
