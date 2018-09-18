//
//  NodeInputView.swift
//  TRXWallet
//
//  Created by  on 2018/6/24.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum NodeType {
    case full
    case solidity
    
    var title: String {
        switch self {
        case .full:
            return "Full Node"
        case .solidity:
            return "Solidity Node"
        }
    }
    
    func save(string: String) {
        switch self {
        case .full:
            UserDefaults.Set.set(string, forKey: .fullnode)
            ServiceHelper.shared.updateNode()
        case .solidity:
            UserDefaults.Set.set(string, forKey: .solidityNode)
            ServiceHelper.shared.updateNode()
        }
    }
    
    func reset() {
        switch self {
        case .full:
            UserDefaults.Set.set(ServiceHelper.fullNode, forKey: .fullnode)
            ServiceHelper.shared.updateNode()
        case .solidity:
            UserDefaults.Set.set(ServiceHelper.solidityNode, forKey: .solidityNode)
            ServiceHelper.shared.updateNode()
        }
    }
    
    func currentAddress() -> String {
        switch self {
        case .full:
            if let nodeComponent = UserDefaults.Set.string(forKey: .fullnode)?.components(separatedBy: ":") {
                return nodeComponent[0]
            } else {
                let nodeComponent = ServiceHelper.fullNode.components(separatedBy: ":")
                return nodeComponent[0]
            }
        case .solidity:
            if let nodeComponent = UserDefaults.Set.string(forKey: .solidityNode)?.components(separatedBy: ":") {
                return nodeComponent[0]
            } else {
                let nodeComponent = ServiceHelper.solidityNode.components(separatedBy: ":")
                return nodeComponent[0]
            }
        }
    }
    
    func currentPort() -> String {
        switch self {
        case .full:
            if let nodeComponent = UserDefaults.Set.string(forKey: .fullnode)?.components(separatedBy: ":") {
                return nodeComponent[1]
            } else {
                let nodeComponent = ServiceHelper.fullNode.components(separatedBy: ":")
                return nodeComponent[1]
            }
        case .solidity:
            if let nodeComponent = UserDefaults.Set.string(forKey: .solidityNode)?.components(separatedBy: ":") {
                return nodeComponent[1]
            } else {
                let nodeComponent = ServiceHelper.solidityNode.components(separatedBy: ":")
                return nodeComponent[1]
            }
        }
    }
}

class NodeInputView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var ipTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet var view: UIView!
    
    
    var nodeType: NodeType = .full {
        didSet {
            titleLabel.text = nodeType.title
            ipTextField.text = nodeType.currentAddress()
            portTextField.text = nodeType.currentPort()
        }
    }
    
    let disposeBag: DisposeBag = DisposeBag()
    
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
        let nib = UINib(nibName: "NodeInputView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.addSubview(view)
        
        // Do any additional setup after loading the view.
    }
    
    func baseConfigure() {
        saveButton.setBackgroundColor(UIColor.normalBackgroundColor, forState: .normal)
        saveButton.setBackgroundColor(UIColor.disabledBackgroundColor, forState: .disabled)
        resetButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        ipTextField.setLeftOffset(15)
        portTextField.setLeftOffset(15)
        let ipSignal = (ipTextField.rx.text).orEmpty.map { return $0.count > 0 }
            .asObservable()
        let portSignal = (portTextField.rx.text).orEmpty.map { return $0.count > 0 }
            .asObservable()
        Observable.combineLatest(ipSignal, portSignal, resultSelector: { (a, b) -> Bool in
            return a && b
        })
            .bind(to: saveButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        (saveButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] () in
                guard let strongSelf = self else { return }
                if let ip = strongSelf.ipTextField.text?.emptyToNil(), let port = strongSelf.portTextField.text?.emptyToNil() {
                    let node = "\(ip):\(port)"
                    strongSelf.nodeType.save(string: node)
                    HUD.showText(text: "Set Success")
                } else {
                    HUD.showText(text: "Set Failed")
                }
            })
        .disposed(by: disposeBag)
        
        (resetButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] () in
                guard let strongSelf = self else { return }
                strongSelf.nodeType.reset()
                HUD.showText(text: "Reset Success")
            })
            .disposed(by: disposeBag)
    }

}
