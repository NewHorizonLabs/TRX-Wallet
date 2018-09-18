//
//  AlerButtonBar.swift
//  New Horizon Labs
//
//  Created by  on 2018/3/28.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import RxSwift

class AlerButtonBar: UIView {
    
    var sureClick:PublishSubject<Void> = PublishSubject<Void>()
    var cancleClick:PublishSubject<Void> = PublishSubject<Void>()
    
    @IBOutlet weak var cancleButton: UIButton!
    
    @IBOutlet weak var sureButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib(){
        // 需要这句代码，不能直接写UINib(nibName: "MyView", bundle: nil)，不然不能在storyboard中显示
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AlerButtonBar", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.addSubview(view)
        
        // Do any additional setup after loading the view.
        baseConfigure()
        
    }
    
    func baseConfigure() {
        (cancleButton.rx.tap).bind {[weak self] in
            self?.cancleClick.onNext(())
        }.disposed(by: disposeBag)
        
        (sureButton.rx.tap).bind {[weak self] in
            self?.sureClick.onNext(())
            }.disposed(by: disposeBag)
    }
    
}
