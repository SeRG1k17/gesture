//
//  PaddingErrorImageTextField.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/2/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class PaddingErrorImageTextField: ErrorImageTextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var errorBorderView: UIView = {
        
        let borderView = UIView(frame: .zero)
        self.addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        let layouts = ["borderView": borderView,"errorLabel": self.errorLabel]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[borderView]|", options: [], metrics: nil, views: layouts))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[borderView]", options: [], metrics: nil, views: layouts))
        self.addConstraint(NSLayoutConstraint(item: borderView, attribute: .bottom, relatedBy: .equal, toItem: self.errorLabel, attribute: .bottom, multiplier: 1.0, constant: 4))
        
        borderView.backgroundColor = .purple
        
        return borderView
    }()
    
    lazy var errorLabel: UILabel = {
        
        let label = UILabel(frame: .zero)
        //let label = UILabel(frame: CGRect(x: 10, y: self.bounds.height + 4, width: self.bounds.width - 20, height: self.bounds.height))
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let layouts = ["label": label]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[label]-(10)-|", options: [], metrics: nil, views: layouts))

        self.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 4))
        
        label.text = "ERROR1233454ngncgn"
        
        label.numberOfLines = 0
        label.backgroundColor = .yellow
        
        return label
    }()
    
    
    override func commonInit() {
        super.commonInit()
        
        addSubview(errorLabel)
        addSubview(errorBorderView)
        errorBorderView.layer.zPosition = errorBorderView.layer.zPosition - 1
    }
    
    override func setup(with fieldStyle: ErrorTextField.FieldStyle) {
        super.setup(with: fieldStyle)
    }

}
