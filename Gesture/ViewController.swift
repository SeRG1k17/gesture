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
        
        let banner = NotificationBanner(title: "Basic Success Notification",
                                        style: .danger)
//        banner.delegate = self
//
//        banner.onTap = {
//            //self.showAlert(title: "Banner Success Notification Tapped", message: "")
//        }
//
//        banner.onSwipeUp = {
//            //self.showAlert(title: "Basic Success Notification Swiped Up", message: "")
//        }
        banner.show(queuePosition: .front, bannerPosition: .top)
        
//        NotificationBanner.shared.showPopup(withMessage: "Some text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text hereSome text here")
        
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

extension ViewController: NotificationBannerDelegate {
    
    internal func notificationBannerWillAppear(_ banner: BaseNotificationBanner) {
        print("[NotificationBannerDelegate] Banner will appear")
    }
    
    internal func notificationBannerDidAppear(_ banner: BaseNotificationBanner) {
        print("[NotificationBannerDelegate] Banner did appear")
    }
    
    internal func notificationBannerWillDisappear(_ banner: BaseNotificationBanner) {
        print("[NotificationBannerDelegate] Banner will disappear")
    }
    
    internal func notificationBannerDidDisappear(_ banner: BaseNotificationBanner) {
        print("[NotificationBannerDelegate] Banner did disappear")
    }
}

