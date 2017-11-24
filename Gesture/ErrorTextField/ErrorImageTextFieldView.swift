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
        didSet {
            errorImageView.image = errorImage
        }
    }
    
    @IBInspectable var imageSidePadding: CGFloat = 8 {
        didSet {
            setUpViews(for: imagePosition)
        }
    }
    
    @IBInspectable var imagePosition: Int = ImagePosition.left.rawValue {
        didSet {
            setUpViews(for: imagePosition)
        }
    }
    
    
    lazy var errorImageView: UIImageView = {
        
        let view = UIImageView(image: self.errorImage)
        view.center.y = self.textField.center.y
        self.addSubview(view)
        
        return view
    }()
    
    
    override func commonInit() {
        super.commonInit()
        
        setUpViews(for: imagePosition)
    }
    
    func setUpViews(for intPosition: Int) {
        
        guard let position = ImagePosition(rawValue: intPosition) else { return }
        
        var imageX: CGFloat!
        
        if position == .left {
            imageX = -(errorImageView.frame.size.width + imageSidePadding)
            
        } else {
            imageX = frame.size.width + imageSidePadding
        }
        
        errorImageView.frame.origin.x = imageX
    }
    
    override func setup(with fieldStyle: ErrorTextFieldView.FieldStyle, animated: Bool) {
        super.setup(with: fieldStyle, animated: animated)
        
        errorImage = fieldStyle.errorImage
        
        UIView.animate(withDuration: duration(animated)) { [weak self] in
            self?.errorImageView.alpha = fieldStyle.errorAlpha
        }
    }
    
    enum ImagePosition: Int {
        case left, right
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

