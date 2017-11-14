//
//  CustomView.swift
//  Gesture
//
//  Created by Sergey Pugach on 9/18/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    static let shared = CustomView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gesture(_:))))
    }
    
    
    
    @objc func gesture(_ sender: UITapGestureRecognizer) {
        print("called")
    }
    
}
