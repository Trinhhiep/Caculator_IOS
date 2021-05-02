//
//  File.swift
//  CaculatorApp
//
//  Created by Admin on 30/04/2021.
//

import Foundation
import UIKit

class CustomButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp()  {
        
    }
}

