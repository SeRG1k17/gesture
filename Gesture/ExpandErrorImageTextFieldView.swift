//
//  PaddingErrorImageTextField.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/2/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class ExpandErrorImageTextFieldView: ErrorImageTextFieldView {
    
    @IBInspectable var errorBorderWidth: CGFloat = 1 {
        didSet {
            errorBorderView.layer.borderWidth = errorBorderWidth
        }
        //set { errorBorderView.layer.borderWidth = newValue }
        //get { return errorBorderView.layer.borderWidth }
    }
    
    @IBInspectable var errorBorderColor: UIColor? {
        set { errorBorderView.layer.borderColor = newValue?.cgColor  }
        get { return errorBorderView.layer.borderColor?.uiColor }
    }
    
    lazy var errorBorderView: UIView = {
        
        let borderView = UIView(frame: .zero)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.cornerRadius = self.cornerRadius
        borderView.backgroundColor = .purple
        
        self.insertSubview(borderView, belowSubview: self.textField)
        
        self.addConstraints([
            NSLayoutConstraint(item: borderView, attribute: .left, relatedBy: .equal, toItem: self.textField, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: borderView, attribute: .right, relatedBy: .equal, toItem: self.textField, attribute: .right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: borderView, attribute: .top, relatedBy: .equal, toItem: self.textField, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: borderView, attribute: .bottom, relatedBy: .equal, toItem: self.errorLabel, attribute: .bottom, multiplier: 1.0, constant: self.verticalPadding)
            ])
        
        return borderView
    }()
    
    let verticalPadding: CGFloat = 4.0
    let errorLabelPadding: CGFloat = 10
    lazy var errorLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: 14)
        
        self.insertSubview(label, belowSubview: self.textField)
        
        self.addConstraints([
            NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: self.textField, attribute: .left, multiplier: 1.0, constant: self.errorLabelPadding),
            NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: self.textField, attribute: .right, multiplier: 1.0, constant: -self.errorLabelPadding),
            NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -self.verticalPadding)
            ])
        
        return label
    }()
    
    lazy var heightConstraint: NSLayoutConstraint! = {

        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.calculateHeight(for: self.fieldStyle))
        self.addConstraint(constraint)

        return constraint
    }()
    
    override func commonInit() {
        super.commonInit()
        
        clipsToBounds = true
    }
    
    override func setup(with fieldStyle: ErrorTextFieldView.FieldStyle, animated: Bool) {
        super.setup(with: fieldStyle, animated: animated)
        
        self.errorBorderWidth = fieldStyle.errorBorderWidth
        self.errorBorderColor = fieldStyle.errorBorderColor
        self.errorBorderView.cornerRadius = fieldStyle.cornerRadius
        
        self.errorLabel.text = fieldStyle.errorText
        self.errorLabel.sizeToFit()
        
        self.superview?.layoutIfNeeded()
        heightConstraint.constant = calculateHeight(for: fieldStyle)
        
        UIView.animate(withDuration: duration(animated)) { [weak self] in
            
            self?.superview?.layoutIfNeeded()
            
            //self?.errorBorderView.alpha = fieldStyle.errorAlpha
            //self?.errorLabel.alpha = fieldStyle.errorAlpha
        }
    }
    
    func calculateHeight(for fieldStyle: ErrorTextFieldView.FieldStyle) -> CGFloat {
        
        var height: CGFloat!
        switch fieldStyle {
        case .normal: height = textField.frame.size.height
        case .error: height = textField.frame.size.height + errorLabel.bounds.size.height + verticalPadding
        }
        
        return height
    }

}

extension ErrorTextFieldView.FieldStyle {
    
    var errorBorderColor: UIColor {
        return .red
    }
    
    var errorBorderWidth: CGFloat {
        return 1
    }
    
    var errorText: String? {
        return "ERROR1233454ngncgndfgdfhdfh"
    }
    
    var isHasError: Bool {
        switch self {
        case .normal: return false
        case .error: return true
        }
    }
    
}
