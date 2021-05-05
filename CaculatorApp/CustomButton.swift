//
//  CustomButton.swift
//  CaculatorApp
//
//  Created by Admin on 30/04/2021.
//

import Foundation
import UIKit
class CustomButton : UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    func setUp()  {
        self.layer.borderWidth = 10
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.cornerRadius = self.bounds.height/2
     
    }
}
