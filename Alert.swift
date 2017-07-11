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

class Alert: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var AlertTitleLabel: UILabel!
    @IBOutlet weak var AlertMessageLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
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
        AlertTitleLabel.text = ""
        AlertMessageLabel.text = ""
        
        leftButton.setTitle("Yes", for: .normal)
        rightButton.setTitle("No", for: .normal)
        
    }
    
    // MARK: Button Actions
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        
        if self.alertInputActions != nil {
            alertInputActions!(AlertButton.VYLeft)
        }
    }
    @IBAction func rightButtonTapped(_ sender: Any) {
        if self.alertInputActions != nil {
            alertInputActions!(AlertButton.VYRight)
            self.hideValeyAlert()
        }
    }
    
    
    func showAlertViewWithTitle(titleStr:String,messageStr:String) -> () {
        let alert:VYAlertView = Bundle.main.loadNibNamed("VYAlertView", owner: self, options: nil)?.first as! VYAlertView
        alert.frame = UIApplication.shared.keyWindow!.frame
        let viewController = UIApplication.shared.keyWindow?.rootViewController
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
