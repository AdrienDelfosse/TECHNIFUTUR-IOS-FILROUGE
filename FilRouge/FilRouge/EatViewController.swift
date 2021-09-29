//
//  EatViewController.swift
//  FilRouge
//
//  Created by Student05 on 15/06/2021.
//

import UIKit
import MapKit
import Alamofire

class EatViewController: UIViewController {
    var businesses =  [Business]()
    @IBOutlet weak var eatTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Manger"
        
        
        setupTableView()
        setupDatas()
        eatTableView.layer.cornerRadius = 20
        
    }
    
    func setupTableView(){
        eatTableView.dataSource = self
        eatTableView.delegate = self
        eatTableView.register(UINib(nibName: "EatTableViewCell", bundle: nil), forCellReuseIdentifier: "EatTableViewCell")
    }
    
    func setupDatas(){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer Nrgvh55Q0RpCwJ2FRc5vt3O098EGSWNgi99bSrbKAaw5KWLKD6fzbbsIS2xLqLWG4xjps_2Iw5uaCqU5Eo8ByNJKiKBI7PlWn8wUApfObqGfXj57ARF9fgYjtCwvYXYx"
        ]
        AF.request("https://api.yelp.com/v3/businesses/search?term=food&latitude=50.59379456353284&longitude=5.560027569777806&limit=10", headers: headers).response { response in
            let JSONData = response.data
            let decoder = JSONDecoder()
            let result = try! decoder.decode(EatData.self, from: JSONData!)
            self.businesses.append(contentsOf: result.businesses)
            self.eatTableView.reloadData()
        }
    }
  
    
    
}

extension EatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eatCell = tableView.dequeueReusableCell(withIdentifier: "EatTableViewCell", for: indexPath) as! EatTableViewCell
        eatCell.setupCell(business: businesses[indexPath.row])
        return eatCell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return  businesses.count
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath:
    IndexPath) -> CGFloat {
    return 150
    }
}

