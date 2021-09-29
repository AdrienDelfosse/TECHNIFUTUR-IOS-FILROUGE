//
//  ViewController.swift
//  FilRouge
//
//  Created by Student05 on 31/05/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var bubleView: UIView!
    

    @IBOutlet var bottomContainerView: UIView!
    
    @IBOutlet weak var mailtextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var mailRegex = "^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$"
    var passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
    
    @IBOutlet weak var loginCheck: UIImageView!
    @IBOutlet weak var passwordCheck: UIImageView!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet var connectionButton: UIButton!
    
    var buttonGradient: CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = connectionButton.bounds
        // color turquoise to aquamarine need to be convert into cgColor
        gradient.colors = [UIColor.turquoise_blue.cgColor, UIColor.aquamarine.cgColor]
        return gradient
    }
    
    @IBAction func didPressOnButton(_ sender: Any) {
        if let homeViewController = storyboard?.instantiateViewController(identifier: "CustomTabBarViewController"){
            homeViewController.modalPresentationStyle = .fullScreen
            present(homeViewController, animated: true, completion: nil)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        setupLabel()
        setupView()
        setupTextView()
        setupButton()
        
        // add notification when keyboard appear and disappear
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    
    func setupLabel(){
        helloLabel.text = "Hey ! Komen ksé ?!"
        helloLabel.textColor = .pink
        
        feedbackLabel.text = ""
        
    }
    
    func setupView(){
        bottomContainerView.backgroundColor = .blueGrey
        bottomContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomContainerView.layer.cornerRadius = 40
        
        bubleView.layer.cornerRadius = 15
    }
    
    func setupButton() {
        connectionButton.setTitle("Se connecter", for: .normal)
        connectionButton.setTitleColor(.white, for: .normal)
        connectionButton.layer.cornerRadius = connectionButton.layer.frame.height/2
        connectionButton.clipsToBounds = true
        connectionButton.backgroundColor = .lightGray
        updateButtonValidity()
    }
    
    func setupTextView(){
        mailtextfield.placeholder = "... ton email"
        mailtextfield.keyboardType = .emailAddress
        mailtextfield.delegate = self
       
        mailtextfield.textColor = .middleBlue
        mailtextfield.layer.cornerRadius = 18.5
        
        mailtextfield.clipsToBounds = true
       

        passwordTextfield.placeholder = "... ton mot de passe"
        passwordTextfield.keyboardType = .default
        passwordTextfield.delegate = self
        passwordTextfield.isSecureTextEntry = true
      
        passwordTextfield.textColor = .middleBlue
        passwordTextfield.layer.cornerRadius =  18.5
        passwordTextfield.clipsToBounds = true
        
        loginCheck.image = nil
        passwordCheck.image = nil
        
        
        let mailIcon = UIImageView(frame: CGRect(x: 15, y: 15, width: 18, height: 18))
        mailIcon.image = UIImage(named: "icoPasswordDarkblue")
        
        let containerIcon = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        containerIcon.addSubview(mailIcon)
        
        passwordTextfield.leftView = containerIcon
        passwordTextfield.leftViewMode = .always
        
        let icon = UIImageView(frame: CGRect(x: 15, y: 15, width: 18, height: 18))
        icon.image = UIImage(named: "icoProfilDarkblue")
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        container.addSubview(icon)
        
        mailtextfield.leftView = container
        mailtextfield.leftViewMode = .always
        
        
      
    }
    
    
    func loginIsValid()-> Bool{
        return NSPredicate(format: "SELF MATCHES %@", mailRegex).evaluate(with: mailtextfield.text)
    }
    
    func passwordIsValid()-> Bool{
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: passwordTextfield.text)
    }

    func updateButtonValidity() {
        if loginIsValid() && passwordIsValid() {
            connectionButton.layer.insertSublayer(buttonGradient, at: 0)
            connectionButton.isUserInteractionEnabled = true
        } else {
            buttonGradient.removeFromSuperlayer()
            connectionButton.isUserInteractionEnabled = false
        }
    }
 
}
extension ViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        // get keyboard frame from notificcation
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            // get keyboard height
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            // update my bottom constraint to add keyboard height
            DispatchQueue.main.async {
                self.buttonBottomConstraint.constant = keyboardHeight + 30
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        // update my bottom constraint to remove keyboard height
        DispatchQueue.main.async {
            self.buttonBottomConstraint.constant = 30
            self.view.layoutIfNeeded()
        }
    }
}
    extension ViewController: UITextFieldDelegate {

        // when user change focus without return key on keyboard -> force call to should return to check validity
        func textFieldDidEndEditing(_ textField: UITextField) {
            if textField == self.mailtextfield {
                let _ = textFieldShouldReturn(mailtextfield)
            } else {
                let _ = textFieldShouldReturn(passwordTextfield)
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.textColor = .middleBlue
            
            self.feedbackLabel.text = "Tap tap tap tap tap tap ..."
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == self.mailtextfield {
                mailtextfield.resignFirstResponder()
                passwordTextfield.becomeFirstResponder()
                
                if(mailtextfield?.text?.isEmpty ?? false){
                    mailtextfield.textColor = .middleBlue
                    loginCheck.image = nil
                    
                    
                } else if(loginIsValid()){
                    loginCheck.image = UIImage(named: "icoCheckGreen")
                    mailtextfield.textColor = .aquamarine
                }else{
                    loginCheck.image = UIImage(named: "icoCrossRed")
                    mailtextfield.textColor = .coral
                }
            } else {
                passwordTextfield.resignFirstResponder()
                if(passwordTextfield?.text?.isEmpty ?? false){
                    passwordTextfield.textColor = .middleBlue
                    passwordCheck.image = nil
                    
                } else if(passwordIsValid()){
                    passwordCheck.image = UIImage(named: "icoCheckGreen")
                    passwordTextfield.textColor = .aquamarine
                }else{
                    passwordCheck.image = UIImage(named: "icoCrossRed")
                    passwordTextfield.textColor = .coral
            }
            }
            
           updateButtonValidity()
                
            updateTextFeedback()
            
            return true
        }
        
        func updateTextFeedback() {
            if !loginIsValid() || !passwordIsValid() {
                self.feedbackLabel.text = "Pas facile de taper avec des gros doigts ..."
            }
            if loginIsValid() && passwordIsValid() {
                self.feedbackLabel.text = "Waaaaaaa ! C'est tout vert !"
            }
        }
        
      
}



