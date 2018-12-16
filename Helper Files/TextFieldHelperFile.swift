//
//  TextFieldHelperFile.swift
//  Surya-test
//
//  Created by Arinjay on 09/12/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//
import UIKit

extension UITextField {
    func validTextFieldStyle(){
        let color = UIColor(red: 51/255.0, green: 122/255.0, blue: 182/255.0, alpha: 1)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func invalidTextFieldStyle(){
        
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
}
