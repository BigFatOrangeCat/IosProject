//
//  ViewController.swift
//  RandomUser
//
//  Created by jichenjiang on 2019/7/18.
//  Copyright © 2019 jichenjiang. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userArray = [UserDetail]()
    var selectedUser: UserDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchUsers()
    }

    func fetchUsers() {
        var request = URLRequest(url: URL(string: "https://randomuser.me/api/?seed=jichen&results=50")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(RandomUser.self, from: data!)
                for user in responseModel.results {
                    self.userArray.append(user)
                }
                print(self.userArray.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("JSON Serialization error: ", error)
            }
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else {
            return
        }
        detailViewController.user = self.selectedUser
    }
    
}


extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInformation") as? UserInformation else {
            return UITableViewCell()
        }
        
        cell.setUser(user: userArray[indexPath.row], index: indexPath.row)
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = userArray[indexPath.row]
        performSegue(withIdentifier: "detail", sender: nil)
    }
}
