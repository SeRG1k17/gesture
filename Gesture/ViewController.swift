//
//  ViewController.swift
//  Gesture
//
//  Created by Sergey Pugach on 9/18/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var expandErrorImageTextFieldView: ErrorTextFieldView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //view.addSubview(CustomView.shared)
    }
    

    @IBAction func showAlerButtonDidTapped(_ sender: UIButton) {
        
        NotificationBanner.shared.showPopup(withMessage: "Some text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text here")
        
//        let vw = NotificationBanner(withType: .error)
//        view.addSubview(vw)
    }
    
    @IBAction func showError(_ sender: UIButton) {
        
        if expandErrorImageTextFieldView.fieldStyle == .normal {
            expandErrorImageTextFieldView.fieldStyle = .error
            
        } else {
            expandErrorImageTextFieldView.fieldStyle = .normal
        }
    }

}

