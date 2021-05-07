//
//  ViewController.swift
//  CaculatorApp
//
//  Created by Admin on 30/04/2021.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    
    var lastKey : String = "Start"
    var equal : Bool?
    var expressionString : String = "(1.0)*"
    
    @IBOutlet weak var lblCaculator: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func btn_click(_ sender: Any) {
      
        let btnTag = (sender as AnyObject).tag
        let str = (lblCaculator.text!).validate
        
        switch btnTag {
        case 0,1,2,3,4,5,6,7,8,9:
            guard str.count < 9 || lastKey != "number" else {
                return
            }
            if equal == true {
                equal = false
            }
            if (lastKey != "number" && lastKey != "," ){
                lblCaculator.text = ""
            }
            
            let text = (lblCaculator.text! + "\(String(btnTag!))")
            expressionString = expressionString + String(btnTag!)
            lblCaculator.text = text
            lastKey = "number"
            break
        case 10:// ,
            guard str.count < 9 else{
                return
            }
            if equal == true {
                
                equal = false
            }
            guard !(lblCaculator.text?.contains(","))! else {
                return
            }
            lblCaculator.text = lblCaculator.text! + ","
            expressionString = expressionString + "."
            lastKey = ","
            break
        case 11: // =
            
            if lastKey == "number"{
                guard let result  = calculate(expressionString) else {
                    return
                }
                if result == Double.infinity{
                    lblCaculator.text = "Lỗi"
                    expressionString = "(1.0)*"
                    lastKey = "Start"
                    print("inf")
                }
                else{
                lblCaculator.text = result.formatDoubleType
                expressionString = String(result)
                equal = true
                    print("non inf")
                }
            }
            
            break
        case 12: //+
            config(1)
            
            break
        case 13: //-
            config(2)
            
            
            
            break
        case 14: //*
            config(3)
            
            
            
            break
        case 15: // /
            config(4)
            
            
            
            break
        case 16: // %
            guard let number1 = Double(lblCaculator.text!.validate) else {
                return
            }
            let val = number1/100
            lblCaculator.text =  val.formatDoubleType
            expressionString = String(val)
            lastKey = ""
            equal = true
            break
        case 17 :// +/-
            guard let number1 = Double(lblCaculator.text!.validate) else {
                return
            }
            let val = number1*(-1)
            lblCaculator.text =  val.formatDoubleType
            expressionString = String(val)
            lastKey = ""
            equal = true
            break
        default:
            expressionString = "(1.0)*"
            lastKey = "Start"
            lblCaculator.text = ""
        }
    }
    
    
    
    
    func config( _ operationType : Int) {
        guard lastKey != "operator" && lastKey != "Start" else{
            return
        }
        lastKey = "operator"
        switch operationType {
        case 1:
            guard let result =  calculate(expressionString)  else {
                return
            }
         
            lblCaculator.text = result.formatDoubleType
            expressionString = String(result) + "+"
            break
        case 2:
            guard let result =  calculate(expressionString)  else {
                return
            }
            lblCaculator.text = result.formatDoubleType
            expressionString = String(result) + "-"
            break
        case 3:
            
            expressionString = expressionString + "*"
            break
        default:
            expressionString = expressionString + "/"
            break
            
        }
        
        
        
    }
    
    func calculate(_ equation: String ) -> Double? {
        
        let expr = NSExpression(format: equation)
       
        guard  let result = expr.expressionValue(with: nil, context: nil) as? Double else {
            return nil
        }
        return result
    }
}

extension Double {
    var formatG: String {
        return  String(format: "%g", self)
    }
    var formatDoubleType : String {
        let num = NSNumber(value: self)
        let numCount = String(num.intValue).count
        if numCount >= 10{
            return  self.formatG
        }
        if self < 1 && abs(num.floatValue) <= 0.0000001{
            return  self.formatG
        }
        let formattedNumber = num.formattedWithSeparator
        return formattedNumber
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 8
        return formatter
    }()
}
extension NSNumber {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
extension String{
    var validate : String{
        if self.contains("."){
            let newString = self.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            if newString.contains(","){
                let newString1 = self.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
                return newString1
            }
            return newString
        }
        if self.contains(","){
            let newString1 = self.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
            return newString1
        }
        return self
    }
}
