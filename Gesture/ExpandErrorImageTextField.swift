//
//  PaddingErrorImageTextField.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/2/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class ExpandErrorImageTextField: ErrorImageTextField {
    
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

        borderView.layer.zPosition = -1
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
    var errorLabelHeightConstraint: NSLayoutConstraint!
    
    
    override func commonInit() {
        
        //addSubview(errorBorderView)
        contentVerticalAlignment = .top
        clipsToBounds = false
        
        addSubview(errorLabel)
        
        setupConstraints()
        
        super.commonInit()
    }
    
    func setupConstraints() {
        
        let views = ["errorLabel": errorLabel] // "borderView": errorBorderView,
        
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[borderView]|", options: [], metrics: nil, views: views))
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[borderView]", options: [], metrics: nil, views: views))
//
//        self.addConstraint(NSLayoutConstraint(item: errorBorderView, attribute: .bottom, relatedBy: .equal, toItem: errorLabel, attribute: .bottom, multiplier: 1.0, constant: 4.0))
        
        
        //Label
        
        let metrics = ["topPadding": self.frame.size.height]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[errorLabel]-(10)-|", options: [], metrics: metrics, views: views))
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-topPadding-[errorLabel]-(>=0,0@900)-|", options: [], metrics: metrics, views: views)

        errorLabelTopConstraint = verticalConstraints.first!
        addConstraints(verticalConstraints)

        errorLabelHeightConstraint = NSLayoutConstraint(item: errorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 0.0)
        errorLabel.addConstraint(errorLabelHeightConstraint)
    }
    
    override func setup(with fieldStyle: ErrorTextField.FieldStyle, animated: Bool) {
        super.setup(with: fieldStyle, animated: animated)
        
        self.errorLabel.text = fieldStyle.errorText
        self.errorLabel.sizeToFit()
        
        self.superview?.layoutIfNeeded()
        
        self.errorLabelHeightConstraint.isActive = !fieldStyle.isHasError
        self.errorLabelTopConstraint.constant = self.frame.size.height
        
        UIView.animate(withDuration: duration(animated)) { [weak self] in
            
            self?.superview?.layoutIfNeeded()
            
            self?.errorBorderWidth = fieldStyle.errorBorderWidth
            self?.errorBorderColor = fieldStyle.errorBorderColor
            self?.errorBorderView.cornerRadius = self?.cornerRadius ?? 0.0
            self?.errorBorderView.alpha = fieldStyle.errorAlpha

            self?.errorLabel.alpha = fieldStyle.errorAlpha
        }
    }

}

extension ErrorTextField.FieldStyle {
    
    var errorBorderColor: UIColor {
        return .red
    }
    
    var errorBorderWidth: CGFloat {
        return 1
    }
    
    var errorText: String? {
        switch self {
        case .normal: return nil
        case .error: return "ERROR1233454ngncgndfgdfhdfh"
        }
    }
    
    var isHasError: Bool {
        switch self {
        case .normal: return false
        case .error: return true
        }
    }
    
}
