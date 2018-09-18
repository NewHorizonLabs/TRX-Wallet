//
//  VoteConfirm.swift
//  TRXWallet
//
//  Created by Maynard on 2018/6/25.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit

class VoteConfirmView: UIView {
    
    var sureBlock: (() -> Void)?
    var cancleBlock: (() -> Void)?

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
        baseConfigure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
        baseConfigure()
    }
    
    private func initViewFromNib(){
        // 需要这句代码，不能直接写UINib(nibName: "MyView", bundle: nil)，不然不能在storyboard中显示
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "VoteConfirmView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.addSubview(view)
        
        // Do any additional setup after loading the view.
    }
    
    func baseConfigure() {
        
        cancelButton.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmClick), for: .touchUpInside)
        
        confirmButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        cancelButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
    }
    
    @objc func cancelClick() {
        cancleBlock?()
    }
    
    @objc func confirmClick() {
        sureBlock?()
    }

}
