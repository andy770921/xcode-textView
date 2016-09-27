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
        
        let newText: String = oldText.stringByReplacingCharactersInRange(range, withString: string)
        //表示newText會顯示在textField上
        
        if (newText as NSString).length  <= 5 {textField.text = newText}
        
        // 第二種寫法如下
        // if newText.characters.count <= 5 {textField.text = newText}
        // 如果寫if oldText.characters.count <= 5 ，最多可打到六位數，怪
            
        else {
            textField.text = (newText as NSString).substringToIndex(5)
    }
       
        
        return false //表示原先oldText隱藏 如果開true會重複顯示
    // 更簡易寫法為，不用if/else函式，直接寫 return newText.length <= 5 直接判斷真假值，如果為假便不會顯示text
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}

class PriceTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        
        var newText: String = oldText.stringByReplacingCharactersInRange(range, withString: string)
        //表示newText會顯示在textField上
        
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
    @IBOutlet weak var SwitchOnOff: UISwitch!
    

    
    @IBAction func SwitchAction(sender: AnyObject) {
        if !SwitchOnOff.on {
        // 或if !(sender as! UISwitch).on
            self.CommentTextF.resignFirstResponder()
        }
    }
    //以上為按Switch時，檢查on/off並使螢幕鍵盤消失的函數。
    //函式的if無法拉出來放在viewDidLoad下，一定要在函式內，如無果放在ViewDidLoad，if函式只會Load時當下檢查一次

    let ZipDelegate = ZipCodeTextFieldDelegate()
    let PriceDelegate = PriceTextFieldDelegate()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.ZipCodeTextF.delegate = ZipDelegate
        self.PriceTextF.delegate = PriceDelegate
        self.CommentTextF.delegate = self
        
        self.SwitchOnOff.setOn(false, animated: true)
        

    }

    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
         return self.SwitchOnOff.on
         }
    //以上為准許編輯的函數
 
        
    func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    //以上為按鍵盤Enter(Return)時，鍵盤會自動消失的函數
    

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

