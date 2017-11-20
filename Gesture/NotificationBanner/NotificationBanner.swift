/*
 
 The MIT License (MIT)
 Copyright (c) 2017 Dalton Hinterscher
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

import UIKit
import SnapKit

public class NotificationBanner: BaseNotificationBanner {
    
    /// Notification that will be posted when a notification banner will appear
    public static let BannerWillAppear: Notification.Name = Notification.Name(rawValue: "NotificationBannerWillAppear")
    
    /// Notification that will be posted when a notification banner did appear
    public static let BannerDidAppear: Notification.Name = Notification.Name(rawValue: "NotificationBannerDidAppear")
    
    /// Notification that will be posted when a notification banner will appear
    public static let BannerWillDisappear: Notification.Name = Notification.Name(rawValue: "NotificationBannerWillDisappear")
    
    /// Notification that will be posted when a notification banner did appear
    public static let BannerDidDisappear: Notification.Name = Notification.Name(rawValue: "NotificationBannerDidDisappear")
    
    /// Notification banner object key that is included with each Notification
    public static let BannerObjectKey: String = "NotificationBannerObjectKey"
    
    /// The view that is presented on the left side of the notification
    private var leftView: UIView!
    
    private var subContentView: UIView!
    private let subContentBorderWidth: CGFloat = 1.0
    
    public override var bannerHeight: CGFloat {
        get {
            if let customBannerHeight = customBannerHeight {
                return customBannerHeight
            } else {
                
                var titleHeight: CGFloat = 0
                let width = appWindow.frame.width - leftView.frame.width - 2 * padding - 2 * subContentBorderWidth
                if let label = titleLabel {
                    
                    let titleSize = label.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
                    titleHeight = titleSize.height - padding
                    
                    let charSize = lroundf(Float(label.font.lineHeight))
                    let rHeight = lroundf(Float(titleHeight))
                    if rHeight / charSize <= 1 {
                        titleHeight = 0
                    }
                }
                
                return super.bannerHeight + titleHeight
            }
        } set {
            customBannerHeight = newValue
        }
    }
    
    private let minDuration: TimeInterval = 3
    private let maxDuration: TimeInterval = 8
    
    public override var duration: TimeInterval {
        
        get {
            guard let label = titleLabel else { return minDuration }
            let lineCount = lroundf(roundf(Float(label.intrinsicContentSize.height)) / roundf(Float(label.font.lineHeight)))
            
            let currentDuration = TimeInterval(lineCount)
            var duration = currentDuration
            
            if currentDuration < minDuration {
                duration = minDuration
                
            } else if currentDuration > maxDuration {
                duration = maxDuration
            }
            
            return duration
        }
        
        set {
            super.duration = newValue
        }
    }
    
    public init(title: String,
                style: BannerStyle = .info,
                colors: BannerColorsProtocol? = nil) {
        
        super.init(style: style, colors: colors)
        
        subContentView = UIView()
        subContentView.backgroundColor = .white
        subContentView.cornerRadius = contentView.cornerRadius
        contentView.addSubview(subContentView)
        
        leftView = UIImageView(image: style.image)
        subContentView.addSubview(leftView)
        
        leftView.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        })
        
        
        titleLabel = UILabel()
        titleLabel!.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel!.textColor = BannerColors().color(for: style)
        titleLabel!.text = title
        titleLabel!.numberOfLines = 0
        
        subContentView.addSubview(titleLabel!)
        
        titleLabel!.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(padding / 2)
            make.left.equalTo(leftView!.snp.right).offset(padding / 2)
            make.right.equalToSuperview().offset(-(padding / 2))
            make.bottom.equalToSuperview().offset(-(padding / 2))
        }
        
        subContentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4 * subContentBorderWidth)
            make.left.equalToSuperview().offset(subContentBorderWidth)
            make.right.equalToSuperview().offset(-subContentBorderWidth)
            make.bottom.equalToSuperview().offset(-subContentBorderWidth)
        }
    }
    
    public convenience init(attributedTitle: NSAttributedString,
                            style: BannerStyle = .info,
                            colors: BannerColorsProtocol? = nil) {
        
        self.init(title: "", style: style, colors: colors)
        titleLabel!.attributedText = attributedTitle
    }
    
    public init(customView: UIView) {
        super.init(style: .none)
        contentView.addSubview(customView)
        customView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
