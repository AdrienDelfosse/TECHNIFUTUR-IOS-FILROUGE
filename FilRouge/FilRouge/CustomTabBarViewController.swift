//
//  CustomTabBarViewController.swift
//  FilRouge
//
//  Created by Student05 on 15/06/2021.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .blue
        tabBar.items![0].image = UIImage(named: "ico_house_white")
        tabBar.items![1].image = UIImage(named: "ico_pizza_white")
        tabBar.items![2].image = UIImage(named: "ico_laugh_white")
        tabBar.items![3].image = UIImage(named: "ico_car_white")
        
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
