//
//  PopTipViewController.swift
//  SoloFitness
//
//  Created by Maynard on 2017/5/8.
//  Copyright © 2017年 New Horizon Labs. All rights reserved.
//

import UIKit
import Ruler
import pop

class PopTipViewController: UIViewController {

    @IBOutlet weak var titleLabelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var cancleButton: UIButton!
    
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var subContentContainerView: UIView!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var subContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    var alertWindow: UIWindow!
    var previousKeyWindow: UIWindow!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var subContainerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalLine: UIView!
    
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    
    var popView: UIView! {
        didSet {
            if let pop = popView {
                contentContainerView.addSubview(pop)
                let height = pop.pheight
                containerViewHeightConstraint.constant = height
                pop.snp.makeConstraints({ (make) in
                    make.center.equalTo(contentContainerView)
                    make.width.equalTo(contentContainerView)
                    make.height.equalTo(height)
                })
            }
        }
    }
    
    // MARK:-
    var sureBlock: ((PopTipViewController) -> Void)?
//    var sureBlock: ((UIView) -> Void)?
    var cancleBlock: ((UIView) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.maskBackgroundColor
//        view.addTapGesture {[unowned self] (tap) in
//            self.dismissPicker()
//        }
//        sureButton.addTarget(self, action: #selector(PickerViewController.sureClick), for: .touchUpInside)
//        cancleButton.addTarget(self, action: #selector(PickerViewController.cancleClick), for: .touchUpInside)
        titleLabel.textColor = UIColor.mainNormalColor
        
        
//        sureButton.setTitleColor(UIColor.deepTitleColor, for: .normal)
//        sureButton.titleLabel?.font = UIFont.SF.font(classify: .display, style: .medium, size: 20)
//        sureButton.setTitle(R.string.localize.oK(), for: .normal)
//        cancleButton.setTitleColor(UIColor.deepTitleColor, for: .normal)
//        cancleButton.titleLabel?.font = UIFont.SF.font(classify: .display, style: .medium, size: 20)
//        cancleButton.setTitle(R.string.localize.cancel(), for: .normal)
//
//        topLineView.backgroundColor = UIColor.lineColor
//        bottomLineView.backgroundColor = UIColor.lineColor
//        lineView.backgroundColor = UIColor.lineColor
//        verticalLine.backgroundColor = UIColor.lineColor
//        cancleButton.setTitleColor(UIColor.subTitleColor, for: .normal)
//        topViewHeightConstraint.constant = Ruler.iPhoneVertical(45, 50, 63, 65).value
//        subContainerViewHeightConstraint.constant = Ruler.iPhoneVertical(60, 70, 90, 90).value
//        bottomViewHeightConstraint.constant = Ruler.iPhoneVertical(45, 50, 63, 65).value
        
        // Do any additional setup after loading the view.
    }
    
    func sureClick() {
        sureBlock?(self)
        
    }
    
    func cancleClick() {
        cancleBlock?(popView)
        dismissPicker()
    }
    
    class func show(popView: UIView, title: String, selectedComplete: @escaping (PopTipViewController) -> Void) {
        let vc = PopTipViewController(nibName: nil, bundle: nil)
        vc.show()
        vc.popView = popView
//        vc.titleLabel.text = title.localString
        vc.titleLabel.textAlignment = .center
        vc.sureBlock = selectedComplete
        vc.titleLabel.font = UIFont.SF.font(classify: .display, style: .bold, size: 24)
        //隐藏subcontent
        vc.subContainerViewHeightConstraint.constant = 0
        vc.titleLabelCenterYConstraint.constant = 0
    }
    
    class func show(popView: UIView, title: String,subTitle: String, content: String, selectedComplete: @escaping (PopTipViewController) -> Void)  {
        let vc = PopTipViewController(nibName: nil, bundle: nil)
        vc.show()
        vc.popView = popView
//        vc.titleLabel.text = title.localString
//        vc.contentLabel.text = content
//        vc.subTitleLabel.text = subTitle.localString
        vc.sureBlock = selectedComplete
        vc.titleLabel.font = UIFont.SF.font(classify: .display, style: .medium, size: 20)
        vc.subTitleLabel.font = UIFont.SF.font(classify: .display, style: .medium, size: 20)
        vc.contentLabel.font = UIFont.SF.font(classify: .display, size: 16)
        vc.contentLabel.textColor = UIColor.deepTitleColor
        vc.topLineView.isHidden = true
        vc.titleLabelCenterYConstraint.constant = 10
    }
    
    
    func show() {
        let screenBounds = UIScreen.main.bounds
        previousKeyWindow = UIApplication.shared.keyWindow
        alertWindow = UIWindow(frame: screenBounds)
        alertWindow.rootViewController = self
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.makeKeyAndVisible()
        alertWindow.backgroundColor = UIColor.clear
        alertWindow.pheight = screenBounds.height
        
        
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)!
        scaleAnimation.fromValue = NSValue(cgSize: CGSize(width: 0.8, height: 0.8))
        scaleAnimation.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnimation.springBounciness = 20.0
        scaleAnimation.springSpeed = 15.0
        
        //            scaleAnimation.duration = 0.1
        //            scaleAnimation.isRemovedOnCompletion = false
        containerView.pop_add(scaleAnimation, forKey: "scale")

//        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
//        scaleAnimation.fromValue = 0.8
//        scaleAnimation.toValue = 1.0
//        scaleAnimation.isRemovedOnCompletion = false
//        scaleAnimation.duration = 0.1
//        containerView.layer.add(scaleAnimation, forKey: "scale")
    }
    
    func dismissPicker() {
        UIView.animate(withDuration: 0.35, animations: {
            self.alertWindow.backgroundColor = UIColor.clear
            self.view.alpha = 0.0
            
        }) { (finished) in
            for subview in self.alertWindow.subviews {
                subview.removeFromSuperview()
            }
            self.previousKeyWindow.makeKeyAndVisible()
            self.alertWindow = nil
            self.previousKeyWindow = nil
        }
    }
    
    deinit {
        print("PickerViewController is delloc---")
    }

}
