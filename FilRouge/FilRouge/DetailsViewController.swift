//
//  DetailsViewController.swift
//  FilRouge
//
//  Created by Student08 on 30/09/2021.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    

    func setupView(){
        
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
        mapView.layoutMargins  = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
