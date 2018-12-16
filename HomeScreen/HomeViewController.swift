//
//  ViewController.swift
//  Surya-test
//
//  Created by Arinjay on 09/12/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//


import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var offlineLabel: UILabel! {
        didSet {
            offlineLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func postData(_ sender: Any) {
        if emailTextField.text != "" {
            if (validateEmail(enteredEmail: emailTextField.text!)){
                offlineLabel.isHidden = true
                self.performSegue(withIdentifier: "toResults", sender: self)
            }else{
                offlineLabel.isHidden = false
                emailTextField.invalidTextFieldStyle()
                offlineLabel.text = "Invalid Email Id"
            }
        }else{
            emailTextField.invalidTextFieldStyle()
            offlineLabel.isHidden = false
            offlineLabel.text = "Enter your email"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        emailTextField.validTextFieldStyle()
        emailTextField.addTarget(self,
                                 action: #selector(changeTextUI (_:)),
                                 for: UIControl.Event.editingDidBegin)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Go to next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ResultViewController
        if emailTextField.text != nil{
            destination.searchKey = emailTextField.text
        }
    }
    
    // for validating email
    func validateEmail(enteredEmail:String) -> Bool { 
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    // change the UI once user taps on textField
    @IBAction func changeTextUI(_ sender: UITextField) {
        emailTextField.validTextFieldStyle()
        offlineLabel.isHidden = true
    }
    
}


