//
//  PaddingErrorImageTextField.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/2/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit


class ExpandErrorImageTextFieldView: ErrorImageTextFieldView {
    
    lazy var errorBorderView: UIView = {
        
        let borderView = UIView(frame: .zero)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.cornerRadius = self.cornerRadius
        borderView.backgroundColor = .white
        
        borderView.borderWidth = 1.0
        borderView.borderColor = FieldStyle.error.borderColor
        
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
    
    private lazy var errorLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        //label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = FieldStyle.error.textColor
        
        self.insertSubview(label, belowSubview: self.textField)
        
        self.addConstraints([
            NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: self.textField, attribute: .left, multiplier: 1.0, constant: self.errorLabelPadding),
            NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: self.textField, attribute: .right, multiplier: 1.0, constant: -self.errorLabelPadding),
            NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -self.verticalPadding)
            ])
        
        return label
    }()
    
    //    lazy var heightConstraint: NSLayoutConstraint! = {
    //
    //        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.calculateHeight(for: self.fieldStyle))
    //        self.addConstraint(constraint)
    //
    //        return constraint
    //    }()
    
    @IBOutlet var heightConstraint: NSLayoutConstraint?
    
    var extraHeight: CGFloat {
        errorLabel.sizeToFit()
        return fieldStyle == .error ? errorLabel.bounds.size.height + verticalPadding : 0
    }
    
    override func commonInit() {
        super.commonInit()
        
        errorBorderView.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    override func setup(with fieldStyle: ErrorTextFieldView.FieldStyle, animated: Bool) {
        super.setup(with: fieldStyle, animated: animated)
        
        self.superview?.layoutIfNeeded()
        
        if var height = heightConstraint {
            
            self.superview?.layoutIfNeeded()
            calculateHeight(for: &height, fieldStyle: fieldStyle)
            
            UIView.animate(withDuration: duration(animated)) { [weak self] in
                self?.superview?.layoutIfNeeded()
            }
        }
    }
    
    func setFieldStyle(_ style: FieldStyle, error: String? = nil) {
        
        errorLabel.text = error
        fieldStyle = style
    }
    
    private func calculateHeight(for constraint: inout NSLayoutConstraint, fieldStyle: ErrorTextFieldView.FieldStyle) {
        
        let extraHeight = errorLabel.bounds.size.height + verticalPadding
        
        switch fieldStyle {
        case .normal: constraint.constant -= extraHeight
        case .error: constraint.constant += extraHeight
        }
    }
    
}

