//
//  ErrorImageTextField.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/2/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class ErrorImageTextField: ErrorTextField {
    
    @IBInspectable var errorImage: UIImage? = #imageLiteral(resourceName: "error") {
        didSet {
            errorImageView.image = errorImage
        }
    }
    
    @IBInspectable var imageOffSet: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            let center = errorImageView.center
            errorImageView.center = CGPoint(x: center.x + imageOffSet.x, y: center.y + imageOffSet.y)
        }
    }
    
    lazy var errorImageView: UIImageView = {
       
        let view = UIImageView(image: self.errorImage)
        view.center = CGPoint(x: -view.bounds.width, y: self.bounds.height / 2)

        return view
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func commonInit() {
        super.commonInit()
        
        addSubview(errorImageView)
    }

    override func setup(with fieldStyle: ErrorTextField.FieldStyle) {
        super.setup(with: fieldStyle)
        
        errorImageView.isHidden = fieldStyle.errorIsHidden
    }
}

extension ErrorTextField.FieldStyle {
    
    var errorIsHidden: Bool {
        switch self {
        case .normal: return true
        case .error: return false
        }
    }
}
