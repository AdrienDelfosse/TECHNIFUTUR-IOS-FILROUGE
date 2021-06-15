//
//  ViewController.swift
//  FilRouge
//
//  Created by Student05 on 31/05/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myView: UIView!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var myButton: UIButton!
    
    @IBAction func didPressOnButton(_ sender: Any) {
        if let homeViewController = storyboard?.instantiateViewController(identifier: "CustomTabBarViewController"){
            homeViewController.modalPresentationStyle = .fullScreen
            present(homeViewController, animated: true, completion: nil)
        }  }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myButton.backgroundColor = .blue
        myButton.setTitle("Se connecter", for: .normal)
        myButton.setTitleColor(.lightGray, for: .normal)
        
        
        
        myView.backgroundColor = .lightGray
        emailTextField.borderStyle = .line
        emailTextField.placeholder = " ton email"
        
        passwordTextField.borderStyle = .line
        passwordTextField.placeholder = " ton mot de passe"
        
        
        
    
        
    }


}

