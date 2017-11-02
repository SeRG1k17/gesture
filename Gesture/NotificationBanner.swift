////////////////////////////////////////////////////////////////////////////////
// COPYRIGHT:       Tandem Diabetes Care 2017.  All rights reserved.
// FILE:            NotificationBanner.swift
// FILE THEME:      The controller for the notifications banner view
// ORIGINAL AUTHOR: Barefoot Solutions
////////////////////////////////////////////////////////////////////////////////

import UIKit

class NotificationBanner: UIView {
    
    static let shared = NotificationBanner(withType: .error)
    
    
    var dismissOnSwipeUp = true
    var onSwipeUp: (() -> ())?
    
    
    private static let maxDuration = 5
    private static let minDuration = 3
    
    private(set) var currentDuration: TimeInterval!
    private(set) var isDisplaying = false
    
    private let appWindow = UIApplication.shared.keyWindow!
    
    
    var titleString: String = "" {
        didSet {
            
            let oldSize = infoLabel.intrinsicContentSize
            infoLabel.text = titleString
            layoutIfNeeded()
            let newSize = infoLabel.intrinsicContentSize
            
            frame.size.height += newSize.height - oldSize.height
        }
    }
    
    private(set) var infoType: InfoType {
        didSet {
            updateSubViews()
        }
    }
    
    private lazy var contentView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        //        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeUpGestureRecognizer))
        //        swipeUpGesture.direction = .up
        //        view.addGestureRecognizer(swipeUpGesture)
        
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTapGestureRecognizer))
        //        view.addGestureRecognizer(tapGestureRecognizer)
        
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        self.addSubview(label)
        
        return label
    }()
    
    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    
    //MARK: - Public Methods
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            showPopupWithMessageInfoType()
    // DESCRIPTION:         Display popup with param
    // PARAMETERS:          msg - text in popup
    //                      infoType - type of banner view
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    public func showPopup(withMessage msg: String, infoType type: InfoType = .error) {
        
        if isHidden {
            
            infoType = type
            titleString = msg
            isHidden = false
            
            transform = CGAffineTransform(translationX: 0, y: -frame.size.height)
            
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.alpha = 1.0
                self?.transform = .identity
                
            }) { [weak self] (finished) in
                
                if finished {
                    self?.hidePopup()
                }
            }
        }
    } // showPopup
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            hidePopup()
    // DESCRIPTION:         Remove popup from veiw
    // PARAMETERS:          duration - animation time for hidding popup
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    public func hidePopup(duration: TimeInterval = 0.3) {
        
        currentDuration = calculateDelay()
        hidePopup(duration: duration, delay: currentDuration)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            hidePopup()
    // DESCRIPTION:         Hides a popup
    // PARAMETERS:          duration - animation time for hidding popup
    //                      delay - time in sec for delay
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    public func hidePopup(duration: TimeInterval = 0.3, delay: TimeInterval) {
        
        if !isHidden {
            
            UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: { [weak self] in
                self?.alpha = 0.0
                
            }) { [weak self] (finished) in
                if finished {
                    self?.isHidden = true
                }
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            init?(coder aDecoder: NSCoder)
    // DESCRIPTION:         Initialized using the data in decoder
    // PARAMETERS:          aDecoder - An unarchiver object.
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private Methods
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            initWithType()
    // DESCRIPTION:         Initialize popup with specific type
    // PARAMETERS:          withType - type of banner view
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    private init(withType type: InfoType) {
        
        infoType = type
        super.init(frame: .zero)
        
        appWindow.addSubview(self)
        
        commonInit()
        updateSubViews()
        
        //isHidden = !isDisplaying
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            commonInit()
    // DESCRIPTION:         Common settings for view
    // PARAMETERS:          n/a
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    private func commonInit() {
        
        layer.cornerRadius = 5
        contentView.layer.cornerRadius = layer.cornerRadius
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        
        setupFrame()
        //setupConstraints()
        gestureRecognizer(for: self)
        setupObserver()
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            setupFrame()
    // DESCRIPTION:         Calculate and set up frame for banner view
    // PARAMETERS:          n/a
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    private func setupFrame() {
        
        let superView: UIView
        
        if let view = superview {
            superView = view
            
        } else {
            superView = UIApplication.shared.keyWindow!
        }
        
        frame = CGRect(x: 10, y: 25, width: superView.frame.size.width - 20, height: 50)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            setupGestureForView()
    // DESCRIPTION:         Set up swipe gesture recognizer
    // PARAMETERS:          view - An object that manages the content
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    private func gestureRecognizer(for view: UIView) {

        isHidden = false
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeUpGestureRecognizer(_:)))
        swipeUpGesture.direction = .up
        addGestureRecognizer(swipeUpGesture)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapGestureRecognizer(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            setupObserver()
    // DESCRIPTION:         Added observer for notificationCenter
    // PARAMETERS:          n/a
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    private func setupObserver() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onOrientationChanged),
                                               name: NSNotification.Name.UIDeviceOrientationDidChange,
                                               object: nil)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            setupConstraints()
    // DESCRIPTION:         Set up NSLayoutConstraint programatically
    // PARAMETERS:          n/a
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    private func setupConstraints() {
        
        let layout = ["contentView": contentView, "infoImageView": infoImageView, "infoLabel": infoLabel]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-1-[contentView]-1-|", options: [], metrics: nil, views: layout))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[contentView]-1-|", options: [], metrics: nil, views: layout))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[infoImageView(24)]-10-[infoLabel]-10-|", options: [], metrics: nil, views: layout))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[infoLabel]-10-|", options: [], metrics: nil, views: layout))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[infoImageView(24)]", options: [], metrics: nil, views: layout))
        
        addConstraint(NSLayoutConstraint(item: infoImageView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0.0))
    } // setupConstraints
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            updateSubViews()
    // DESCRIPTION:         Update view components
    // PARAMETERS:          n/a
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    private func updateSubViews() {
        
        backgroundColor = infoType.infoColor
        infoLabel.textColor = infoType.infoColor
        //layer.borderColor = infoType.infoColor.cgColor
        infoImageView.image = infoType.infoImage
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            onOrientationChanged()
    // DESCRIPTION:         Handle orientation changed notification
    // PARAMETERS:          n/a
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    @objc private func onOrientationChanged() {
        //setupConstraints()
        //frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: appWindow.frame.width, height: frame.height)
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            onSwipeUpGestureRecognizer()
    // DESCRIPTION:         Handle swipe for closing popup
    // PARAMETERS:          n/a
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    @objc private func onSwipeUpGestureRecognizer(_ sender: UISwipeGestureRecognizer) {
        
        //if dismissOnSwipeUp {
            hidePopup()
        //}
        
        onSwipeUp?()
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            onTapGestureRecognizer()
    // DESCRIPTION:         Handle tap for closing popup
    // PARAMETERS:          n/a
    // RETURNS:             void
    ////////////////////////////////////////////////////////////////////////////////
    @objc private func onTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        //if dismissOnTap {
        hidePopup(delay: 0)
        //}
        
        //onTap?()
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////
    // FUNCTION:            calculateDelay()
    // DESCRIPTION:         Calculate delay
    // PARAMETERS:          n/a
    // RETURNS:             TimeInterval
    ////////////////////////////////////////////////////////////////////////////////
    private func calculateDelay() -> TimeInterval {
        
        var lineCount = 0
        let textSize = CGSize(width: infoLabel.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(infoLabel.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(infoLabel.font.lineHeight))
        lineCount = rHeight/charSize
        
        var duration = 0
        if lineCount < NotificationBanner.minDuration {
            duration = NotificationBanner.minDuration
            
        } else if lineCount > NotificationBanner.maxDuration {
            duration = NotificationBanner.maxDuration
            
        } else {
            duration = lineCount
        }
        
        return TimeInterval(duration)
    } // calculateDelay
    
    enum InfoType {
        case success, info, alert, error
        
        var infoColor: UIColor {
            switch self {
            case .success: return .green
            case .info: return .blue
            case .alert: return .orange
            case .error: return .red
            } // switch
        }
        
        
        var textColor: UIColor {
            switch self {
            case .success: return .green
            case .info: return .blue
            case .alert: return .red
            case .error: return  .red
            } // switch
        }
        
        
        var infoImage: UIImage {
            switch self {
            case .error: return #imageLiteral(resourceName: "error")
            case .success: return #imageLiteral(resourceName: "success")
                
            //TODO: add cases
            default: return #imageLiteral(resourceName: "error")
            } // switch
        }
    }
    
}

