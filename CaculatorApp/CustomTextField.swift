//
//  CustomTextField.swift
//  CaculatorApp
//
//  Created by Admin on 04/05/2021.
//

import Foundation
import UIKit
class CustomTextField: UITextField {
    var str : String?
    
    func addText(_ char : Character) {
        
    }
   
    func formatText(_ str : String) -> NSNumber {
        if (str.contains(".")){
            let newString = str.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            if (newString.contains(",")){
                let newString = newString.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
                return NSNumber(pointer: newString)
            }
            return NSNumber(pointer: newString)
            
        }else
        if (str.contains(",")){
            let newString = str.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
            return NSNumber(pointer: newString)
        }
        
        return NSNumber(pointer: str)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        return formatter
    }()
}
extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
