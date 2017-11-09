//
//  InsetsTextField.swift
//  Gesture
//
//  Created by Sergey Pugach on 05.11.17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class InsetsTextField: UITextField {
    
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, insets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, insets)
    }
}

//extension UITextField {
//
//    class func textField(with insets: UIEdgeInsets) -> UITextField {
//        return InsetTextField(insets: insets)
//    }
//
//}

