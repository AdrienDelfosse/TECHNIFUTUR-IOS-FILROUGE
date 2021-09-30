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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private var currentLocation: CLLocation?
    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Manger"
        
        setupView()
        getCurrentLocation()
        
    }
    
    func setupView(){
        self.title = "Manger"
        segmentedControl.backgroundColor = .aquamarine
        view.backgroundColor = .blueGrey
        eatTableView.backgroundColor = .blueGrey
        mapView.delegate = self
        mapView.layoutMargins  = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        setupTableView()
    }
    func setupTableView(){
        eatTableView.layer.cornerRadius = 20

        eatTableView.tableFooterView = UIView()
        eatTableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        eatTableView.scrollIndicatorInsets = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
        
        let tableBackgroundImage = UIImageView(image: UIImage(named: "bgGrey"))
        tableBackgroundImage.contentMode = .bottomLeft
        eatTableView.backgroundView = tableBackgroundImage
        
        eatTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        eatTableView.layer.masksToBounds = true
        eatTableView.dataSource = self
        eatTableView.delegate = self
        eatTableView.register(UINib(nibName: "EatTableViewCell", bundle: nil), forCellReuseIdentifier: "EatTableViewCell")
    }
    
    
    
    private func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    private func displayBusinesses(_ businesses: [Business]) {
        eatTableView.reloadData()
        locationManager.stopUpdatingLocation()
        
        let annotations = businesses.map { business -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = business.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: business.coordinates.latitude,
                                                           longitude: business.coordinates.longitude)
            return annotation
        }
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = storyboard?.instantiateViewController(identifier:
        "DetailsViewController")
        navigationController?.pushViewController(detailsViewController!, animated: true)
    }
}


extension EatViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            BusinessService.shared.businesses(at: location) { businesses in
                guard let businesses = businesses,
                      self.currentLocation == nil
                else {
                    // TODO: Manage error
                    return
                }
                
                self.businesses = businesses
                self.currentLocation = location
                self.displayBusinesses(businesses)
            }
        }
    }
}
extension EatViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "icoPinPizza")
            annotationView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.73)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}



