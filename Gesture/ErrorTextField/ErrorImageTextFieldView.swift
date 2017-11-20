//
//  ErrorImageTextField.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/2/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class ErrorImageTextFieldView: ErrorTextFieldView {
    
    @IBInspectable var errorImage: UIImage? {
        //        get { return errorImageView.image }
        //        set { errorImageView.image = newValue }
        didSet {
            errorImageView.image = errorImage
        }
    }
    
    @IBInspectable var imageSidePadding: CGFloat = 0 {
        didSet {
            var center = errorImageView.center
            center.x += imageSidePadding
            errorImageView.center.x += imageSidePadding//center
        }
    }
    
    lazy var errorImageView: UIImageView = {
        
        let view = UIImageView(image: self.errorImage)
        view.center = CGPoint(x: view.bounds.size.width / 2, y: self.textField.center.y)
        self.addSubview(view)
        
        return view
    }()
    
    
    override func commonInit() {
        super.commonInit()
        
        setupViews()
    }
    
    func setupViews() {
        
        var fieldFrame = textField.frame
        let translation = errorImageView.frame.maxX + imageSidePadding
        fieldFrame.origin.x += errorImageView.frame.maxX + imageSidePadding
        fieldFrame.size.width -= 2 * translation
        
        textField.frame = fieldFrame
    }
    
    override func setup(with fieldStyle: ErrorTextFieldView.FieldStyle, animated: Bool) {
        super.setup(with: fieldStyle, animated: animated)
        
        errorImage = fieldStyle.errorImage
        
        UIView.animate(withDuration: duration(animated)) { [weak self] in
            self?.errorImageView.alpha = fieldStyle.errorAlpha
        }
    }
}

extension ErrorTextFieldView.FieldStyle {
    
    var errorImage: UIImage? {
        return #imageLiteral(resourceName: "error")
    }
    
    var errorAlpha: CGFloat {
        switch self {
        case .normal: return 0.0
        case .error: return 1.0
        }
    }
}

