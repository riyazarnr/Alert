//
//  Alert.swift
//  Valet
//
//  Created by Riyaz Shaik on 11/07/17.
//  Copyright © 2017 RiyazARNR. All rights reserved.
//

import UIKit

enum AlertButton {
    case VYLeft
    case VYRight
    case VYNil
    
};

class VYAlertView: UIView {
    @IBOutlet weak var AlertTitleLabel: UILabel!
    @IBOutlet weak var AlertMessageLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    // Completion Block for Buttons
    
    //    var alertInputActions : ((AlertButton) -> AlertButton)?
    
    var alertInputActions: ((_ input: AlertButton) -> ())?
    override init(frame: CGRect) {
        if self.alertInputActions != nil {
            alertInputActions!(AlertButton.VYNil)
        }
        super.init(frame: frame)
        self.SetUpAlert()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpAlert(){
        
    }
    
    // MARK: Button Actions
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        
        if self.alertInputActions != nil {
            alertInputActions!(AlertButton.VYLeft)
        }
        //        if (delegate != nil) {
        //   delegate?.buttonActionTapped(.VYLeft)
        //        }
    }
    @IBAction func rightButtonTapped(_ sender: Any) {
        if self.alertInputActions != nil {
            alertInputActions!(AlertButton.VYRight)
            self.hideValeyAlert()
        }
        //        if (delegate != nil) {
        self.hideValeyAlert()
        //        }
    }
    
    
    class  func showAlertViewWithTitle(titleStr:String,messageStr:String) -> () {
        let viewController = UIApplication.shared.keyWindow?.rootViewController
        let alert:VYAlertView = Bundle.main.loadNibNamed("VYAlertView", owner: nil, options: nil)?.first as! VYAlertView
        alert.frame = UIApplication.shared.keyWindow!.frame
        alert.AlertTitleLabel.text = titleStr
        alert.AlertMessageLabel.text = messageStr
        alert.contentView.center = alert.center
        if alert.alertInputActions == nil {
            alert.alertInputActions?(AlertButton.VYNil)
        }
        if (viewController!.isKind(of:UIViewController.self)) {
            let vc = viewController
            vc!.view.addSubview(alert)
        }
        
    }
    
    func hideValeyAlert() {
        var responder: UIResponder? = self
        while responder != nil {
            if let responder = responder as? UIViewController {
                for view in (responder.view.subviews) {
                    if view is VYAlertView {
                        view.removeFromSuperview()
                    }
                }
            }
            responder = responder?.next
        }
    }
}

