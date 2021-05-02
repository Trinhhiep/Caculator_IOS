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
    var saveVal : Float?
    @IBOutlet weak var lblCaculator: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction func btn_click(_ sender: Any) {
        
        let btnTag = (sender as AnyObject).tag
        let number = Float(lblCaculator.text!)
        
        switch btnTag {
        case 0,1,2,3,4,5,6,7,8,9:
            print(lastKey)
            if lastKey != "number" && lastKey != "."{
                lblCaculator.text = ""
            }
            lblCaculator.text = lblCaculator.text! + "\(String(btnTag!))"
            lastKey = "number"
            break
        case 10:
            guard !(lblCaculator.text?.contains("."))! else {
                return
            }
            lblCaculator.text = lblCaculator.text! + "."
            lastKey = "number"
            break
        case 11: // =
            
            guard saveVal != nil && currentOperation != 0 && number != nil else{
                return
            }
            
            caculated(operationType: currentOperation, number: number!, typeOfCaculate: currentOperation)
            lastOperation = 0
            
            
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
            lblCaculator.text = val.clean
            break
        case 17 :// +/-
            guard number != nil else {
                return
            }
            let val = number!*(-1)
             lblCaculator.text = val.clean
        break
        default:
            saveVal = nil
            lblCaculator.text = ""
        }
        
        
    }
    
 
    
    func caculated(operationType : Int , number : Float , typeOfCaculate : Int) {
        if lastOperation == 0 {
            
            lastOperation = operationType
           
        }
        if lastKey == "operator" || lastKey == "Start" {
            return
        }
        
        
        guard saveVal != nil else {
            saveVal = Float(lblCaculator.text!)!
            lastKey = "operator"
            lastOperation = operationType
            currentOperation = operationType// cho dau =
            return
        }
       
        switch typeOfCaculate {
        case 1:
            
            saveVal = saveVal! + number
            lblCaculator.text = String(saveVal!.clean)
            
            break
            
        case 2:
            
            saveVal = saveVal! - number
            lblCaculator.text = String(saveVal! .clean)
            
            break
        case 3:
            
            saveVal = saveVal! * number
            lblCaculator.text = String(saveVal!.clean)
            
            break
            
        default:
            
            saveVal = saveVal! / number
            lblCaculator.text = String(saveVal!.clean)
         
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
