//
//  ErrorTextField.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/2/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

extension UITextField {
    
    @IBInspectable var _textColor: UIColor? {
        
        get { return textColor }
        set {
            textColor = newValue

            guard let attr = attributedText else { return }
            let mutableAttr = NSMutableAttributedString(attributedString: attr)
            mutableAttr.setAttributes([NSForegroundColorAttributeName: newValue as Any], range: NSMakeRange(0, attr.length))
                
            attributedText = mutableAttr
        }
    }
}


@IBDesignable class ErrorTextField: UITextField {
    
    var fieldStyle: FieldStyle {
        get { return FieldStyle(rawValue: style)! }
        set {
            //guard let value = newValue?.rawValue else { return }
            style = newValue.rawValue
        }
    }
    
    @IBInspectable var style: Int = 0 {
        didSet {
            setup(with: fieldStyle)
        }
        //set { setup(with: newValue) }
        //get { return nil }
    }
    
//    @IBInspectable var textFieldOffSet: CGPoint = CGPoint(x: 0, y: 0) {
//        didSet {
//            self.textField.frame.origin = CGPoint(x: frame.origin.x + textFieldOffSet.x, y: frame.origin.y + textFieldOffSet.y)
//        }
//    }
//
//    lazy var textField: UITextField = {
//
//        let offSet = self.textFieldOffSet
//        let field = UITextField(frame: CGRect(x: offSet.x, y: offSet.y,
//                                              width: self.frame.size.width - 2 * offSet.x,
//                                              height: self.frame.size.height - 2 * offSet.y))
//
//        self.addSubview(field)
//        return field
//    }()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        setup(with: fieldStyle)
    }
    
    func setup(with fieldStyle: FieldStyle) {
        
        //guard let fieldStyle = fieldStyle else { return }
        cornerRadius = fieldStyle.cornerRadius
        borderColor = fieldStyle.borderColor
        borderWidth = fieldStyle.borderWidth
        _textColor = fieldStyle.textColor
    }
    
    
    enum FieldStyle: Int {
        case normal, error
        
        var cornerRadius: CGFloat { return 5 }
        
        var borderColor: UIColor {
            switch self {
            case .normal: return .black
            case .error: return .red
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .normal: return 1
            case .error: return 2
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .normal: return .black
            case .error: return .red
            }
        }
    }
}
