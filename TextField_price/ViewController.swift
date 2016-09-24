//
//  ViewController.swift
//  TextField_price
//
//  Created by Andy Chou on 2016/9/25.
//  Copyright © 2016年 Andy Chou. All rights reserved.
//

import UIKit

class ZipCodeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}

class PriceTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ZipCodeTextF: UITextField!
    @IBOutlet weak var PriceTextF: UITextField!
    @IBOutlet weak var CommentTextF: UITextField!
    
    @IBAction func ControlTypeSwitch(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ZipCodeTextF.delegate = ZipCodeTextFieldDelegate()
        self.PriceTextF.delegate = PriceTextFieldDelegate()
        self.CommentTextF.delegate = self
        
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            
            return true
    }
        
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true
        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

