//
//  SmileViewController.swift
//  FilRouge
//
//  Created by Student05 on 15/06/2021.
//

import UIKit
import Alamofire

class SmileViewController: UIViewController {

    @IBOutlet weak var jokeTableView: UITableView!
    
    var jokes =  [Joke]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rigoler"
        setupDatas()
        setupTableView()
    }
    
    
    func setupTableView() {

        jokeTableView.dataSource = self
        jokeTableView.delegate = self
        jokeTableView.register(UINib(nibName: "JokeTableViewCell", bundle: nil), forCellReuseIdentifier: "JokeTableViewCell")
    }
    
    func setupDatas(){
        AF.request("https://api.icndb.com/jokes/random/20").response { response in
            let JSONData = response.data
            let decoder = JSONDecoder()
            let result = try! decoder.decode(JokeData.self, from: JSONData!)
            self.jokes.append(contentsOf: result.value)
            self.jokeTableView.reloadData()
        }
    }
    

}

extension SmileViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let jokeCell = tableView.dequeueReusableCell(withIdentifier: "JokeTableViewCell", for: indexPath) as! JokeTableViewCell
        jokeCell.setupTableView(joke: jokes[indexPath.row])
        return jokeCell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return  jokes.count
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath:
    IndexPath) -> CGFloat {
    return 200
    }
}
