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

        //borderView.layer.zPosition = -1
        borderView.layer.cornerRadius = self.cornerRadius
        borderView.backgroundColor = .purple
        
        return borderView
    }()
    
    let errorLabelPadding: CGFloat = 10
    lazy var errorLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)
        label.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
            
            
        
        label.numberOfLines = 0
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    var errorLabelTopConstraint: NSLayoutConstraint!
    var errorLabelBottomConstraint: NSLayoutConstraint!
    var errorLabelHeightConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    var verticalPadding: CGFloat = 4.0
    
    override func commonInit() {
        super.commonInit()
        
        insertSubview(errorBorderView, belowSubview: textField)
        insertSubview(errorLabel, belowSubview: textField)
        
        setupConstraints()
        
        clipsToBounds = true
    }
    
    func setupConstraints() {
        
        let views = ["errorLabel": errorLabel, "borderView": errorBorderView]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[borderView]|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[borderView]", options: [], metrics: nil, views: views))

        self.addConstraint(NSLayoutConstraint(item: errorBorderView, attribute: .bottom, relatedBy: .equal, toItem: errorLabel, attribute: .bottom, multiplier: 1.0, constant: 4.0))
        
        
        //Label
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[errorLabel]-(10)-|", options: [], metrics: nil, views: views))
        
//        errorLabelTopConstraint = NSLayoutConstraint(item: errorLabel, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
//        addConstraint(errorLabelTopConstraint)
        
//        let metrics = ["topPadding": self.frame.size.height]
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[errorLabel]-(10)-|", options: [], metrics: metrics, views: views))
//
//        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[errorLabel]-(>=0,0@900)-|", options: [], metrics: nil, views: views)

        //errorLabelTopConstraint = verticalConstraints.first!
        //addConstraints(verticalConstraints)
//
        errorLabelBottomConstraint = NSLayoutConstraint(item: errorLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -verticalPadding)

        addConstraint(errorLabelBottomConstraint)
        
//        errorLabelHeightConstraint = NSLayoutConstraint(item: errorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.0)
//        errorLabel.addConstraint(errorLabelHeightConstraint)
        
//        errorLabelTopConstraint = NSLayoutConstraint(item: errorLabel, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .top, multiplier: 1.0, constant: 0.0)
//
//        addConstraint(errorLabelTopConstraint)
        
        //field
        
        heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: textField.bounds.size.height)
        
        addConstraint(heightConstraint)
    }
    
    override func setup(with fieldStyle: ErrorTextFieldView.FieldStyle, animated: Bool) {
        super.setup(with: fieldStyle, animated: animated)
        
        self.errorLabel.text = fieldStyle.errorText
        self.errorLabel.sizeToFit()
        
        self.superview?.layoutIfNeeded()
        
        if errorLabelBottomConstraint != nil {
            
            let newHeight = errorLabel.bounds.size.height + verticalPadding
            heightConstraint.constant += fieldStyle == .error ? newHeight : -newHeight
            
            //errorLabelHeightConstraint.constant = fieldStyle == .error ? self.errorLabel.bounds.size.height : 0.0
            //errorLabelBottomConstraint.isActive = !fieldStyle.isHasError
            //errorLabelHeightConstraint.isActive = fieldStyle.isHasError
            
            //errorLabelTopConstraint.constant = fieldStyle == .error ? textField.bounds.size.height : 0
            //errorLabelHeightConstraint.constant = errorLabel.bounds.size.height
            
            //errorLabelBottomConstraint.constant = self.errorLabel.bounds.size.height
            //errorLabelHeightConstraint.constant = self.errorLabel.bounds.size.height
            //errorLabelTopConstraint.constant = self.textField.bounds.size.height
        }
        //
        //self.errorLabelTopConstraint.constant = self.frame.size.height
        
        UIView.animate(withDuration: duration(animated)) { [weak self] in
            
            self?.superview?.layoutIfNeeded()
            
//            if let label = self?.errorLabel, self?.errorLabelHeightConstraint != nil {
//                self?.errorLabelHeightConstraint.constant = label.bounds.size.height
//            }
            self?.errorBorderWidth = fieldStyle.errorBorderWidth
            self?.errorBorderColor = fieldStyle.errorBorderColor
            self?.errorBorderView.cornerRadius = self?.cornerRadius ?? 0.0
            self?.errorBorderView.alpha = fieldStyle.errorAlpha

            self?.errorLabel.alpha = fieldStyle.errorAlpha
        }
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
//        switch self {
//        case .normal: return nil
//        case .error: return "ERROR1233454ngncgndfgdfhdfh"
//        }
    }
    
    var isHasError: Bool {
        switch self {
        case .normal: return false
        case .error: return true
        }
    }
    
}
