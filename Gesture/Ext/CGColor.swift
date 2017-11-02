//
//  CGColor.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/2/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

extension CGColor {
    var uiColor: UIColor {
        return UIColor(cgColor: self) //UIColor(cgColor: self)
    }
}
