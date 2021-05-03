//
//  ViewController.swift
//  CaculatorApp
//
//  Created by Admin on 30/04/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var lastKey : String = "Start"
    var currentOperation = 0
    var lastOperation = 0
    var saveVal : Double?
    var equal : Bool?
    @IBOutlet weak var lblCaculator: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func btn_click(_ sender: Any) {
        
        let btnTag = (sender as AnyObject).tag
        
        let str = formatText(lblCaculator.text!)
        guard str.count < 10  else {
            lblCaculator.text = ""
            saveVal = nil
            return
        }
        let number = Double(str)
        
        switch btnTag {
        case 0,1,2,3,4,5,6,7,8,9:
            
            guard str.count < 9 || lastKey != "number" else {
                return
            }
            if equal == true {
                saveVal = nil
                equal = false
            }
            if lastKey != "number" && lastKey != ","{
                lblCaculator.text = ""
            }
            let text = formatText(lblCaculator.text! + "\(String(btnTag!))")
            
           toPrintNumber(number: Double(text)!)
            

            lastKey = "number"
            
            
            break
        case 10:// ,
            if equal == true {
                saveVal = nil
                equal = false
            }
            guard !(lblCaculator.text?.contains(","))! else {
                
                return
            }
            lblCaculator.text = lblCaculator.text! + ","
            lastKey = ","
            break
        case 11: // =
            
            guard saveVal != nil && currentOperation != 0 && number != nil else{
                return
            }
            
            caculated(operationType: currentOperation, number: number!, typeOfCaculate: currentOperation)
            lastOperation = 0
            equal = true
            
            break
        case 12: //+
            
            guard number != nil else {
                return
            }
            caculated(operationType: 1,number: number!, typeOfCaculate: lastOperation)
            currentOperation = 1
            break
            
        case 13: //-
            guard number != nil else {
                return
            }
            caculated(operationType: 2,number: number!, typeOfCaculate: lastOperation)
            currentOperation = 2
            
            break
        case 14: //*
            guard number != nil else {
                return
            }
            caculated(operationType: 3,number: number!, typeOfCaculate: lastOperation)
            currentOperation = 3
            break
        case 15: // /
            guard number != nil else {
                return
            }
            caculated(operationType: 4,number: number!, typeOfCaculate: lastOperation)
            currentOperation = 4
            break
        case 16: // %
            
            guard number != nil else {
                return
            }
            let val = number!/100
            toPrintNumber(number: val)
            
            
            lastKey = "operator"
            equal = true
            break
        case 17 :// +/-
            
            guard number != nil else {
                return
            }
            let val = number!*(-1)
            toPrintNumber(number: val)
        
            
            lastKey = "operator"
            equal = true
            break
        default:
            saveVal = nil
            lblCaculator.text = ""
        }
        
        
    }
    
    func formatText(_ str : String) -> String {
        if (str.contains(".")){
            let newString = str.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            if (newString.contains(",")){
                let newString = newString.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
                return newString
            }
            return newString
            
        }else
        if (str.contains(",")){
            let newString = str.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
            return newString
        }
        
        return str
    }
    
    func toPrintNumber(number : Double){
        let number = NSNumber(value: number)
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.decimalSeparator = ","
        formater.numberStyle = .decimal
        formater.maximumFractionDigits = .max
        let formattedNumber = formater.string(from: number)!
        lblCaculator.text = String(formattedNumber)
        
    }
    
    
    func caculated(operationType : Int , number : Double , typeOfCaculate : Int) {
        print(lastKey)
        if equal == true {
            equal = false
        }
        if lastOperation == 0 {
            
            lastOperation = operationType
            
        }
        if lastKey == "operator" || lastKey == "Start" {
            return
        }
        
        
        guard saveVal != nil else {
            saveVal = Double(formatText( lblCaculator.text!))!
            lastKey = "operator"
            lastOperation = operationType
            currentOperation = operationType// cho dau =
            return
        }
        
        switch typeOfCaculate {
        case 1:
            
            saveVal = (saveVal! + number)
           toPrintNumber(number: Double(saveVal!))
           
            
            
            break
            
        case 2:
            
            saveVal = (saveVal! - number)
            toPrintNumber(number: Double(saveVal!))
            break
        case 3:
            
            saveVal = (saveVal! * number)
            toPrintNumber(number: Double(saveVal!))
            break
            
        default:
            
            saveVal = (saveVal! / number)
            toPrintNumber(number: Double(saveVal!))
            break
        }
        lastOperation  = operationType
        currentOperation = operationType
        
        lastKey = "operator"
        
    }
    
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
