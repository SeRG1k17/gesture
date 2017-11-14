//
//  ErrorImageTextField.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/2/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class ErrorImageTextFieldView: ErrorTextFieldView {
    
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
    
    
    override func commonInit() {
        super.commonInit()
        
        addSubview(errorImageView)
    }

    override func setup(with fieldStyle: ErrorTextFieldView.FieldStyle, animated: Bool) {
        super.setup(with: fieldStyle, animated: animated)
        
        UIView.animate(withDuration: duration(animated)) { [weak self] in
            self?.errorImageView.alpha = fieldStyle.errorAlpha
        }
    }
}

extension ErrorTextFieldView.FieldStyle {
    
    var errorAlpha: CGFloat {
        switch self {
        case .normal: return 0.0
        case .error: return 1.0
        }
    }
}
