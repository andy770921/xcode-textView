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
    
        let oldText = textField.text! as NSString
        
        let newText: String = oldText.stringByReplacingCharactersInRange(range, withString: string) //表示newText會顯示在textField上
        
        //if String(oldText).characters.count < 5 {textField.text = newText}
        //else {
            textField.text = (newText as NSString).substringToIndex(5)
    //}
       
        
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true //表示原先oldText隱藏 如果開true會重複顯示
    }
    
}

class PriceTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        
        var newText: String = oldText.stringByReplacingCharactersInRange(range, withString: string) //表示newText會顯示在textField上
        
        // 以下為擷取數字進numOfPennies的code
        // 如果直接把newText強迫轉型Int，會因為打第二個數字後開始有錢的符號，進而出現問題
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        var numOfPennies: String = ""
        for c in newText.unicodeScalars {
            if digits.longCharacterIsMember(c.value) {
                numOfPennies.append(c)
            }
        }
        //
        
        let dollarInt = Int(numOfPennies)!/100
        let dollarString: String = "$" + "\(dollarInt)" + "."
        let centsString: String =  String(Int(numOfPennies)! % 100)
        newText = dollarString + centsString

        textField.text = newText
        
        return false //表示原先oldText隱藏 如果開true會重複顯示
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
    let ZipDelegate = ZipCodeTextFieldDelegate()
    let PriceDelegate = PriceTextFieldDelegate()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.ZipCodeTextF.delegate = ZipDelegate
        self.PriceTextF.delegate = PriceDelegate
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

