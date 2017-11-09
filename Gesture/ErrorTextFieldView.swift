//
//  ErrorTextFieldView.swift
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


@IBDesignable class ErrorTextFieldView: UIView {
    
    
    @IBInspectable var animated: Bool = true
    @IBInspectable var animateDuration: TimeInterval = 1
    
    @IBInspectable var textFieldSideInset: CGFloat = 16 {
        didSet {
            setSideInset(textFieldSideInset, for: textField)
        }
    }

    @IBInspectable var style: Int = 0 {
        didSet {
            setup(with: fieldStyle, animated: animated)
        }
    }
    
    var fieldStyle: FieldStyle {
        get { return FieldStyle(rawValue: style)! }
        set { style = newValue.rawValue }
    }

    lazy var textField: InsetsTextField = {

        let size = self.frame.size
        let field = InsetsTextField(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        field.autoresizingMask = [.flexibleWidth]
        field.backgroundColor = .green
        self.setSideInset(self.textFieldSideInset, for: field)
        self.addSubview(field)
        
        return field
    }()
    
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        setup(with: fieldStyle, animated: false)
        
        backgroundColor = .blue
    }
    
    func setup(with fieldStyle: FieldStyle, animated: Bool) {
        
        UIView.animate(withDuration: duration(animated)) { [weak self] in
            
            self?.cornerRadius = fieldStyle.cornerRadius
            
            self?.textField.cornerRadius = fieldStyle.cornerRadius
            self?.textField.borderColor = fieldStyle.borderColor
            self?.textField.borderWidth = fieldStyle.borderWidth
            self?.textField._textColor = fieldStyle.textColor
        }
    }
    
    func duration(_ animated: Bool) -> TimeInterval {
        return animated == true ? animateDuration : 0.0
    }
    
    
    func setSideInset(_ inset: CGFloat, for textField: InsetsTextField) {
        textField.insets.left = inset
        textField.insets.right = inset
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
