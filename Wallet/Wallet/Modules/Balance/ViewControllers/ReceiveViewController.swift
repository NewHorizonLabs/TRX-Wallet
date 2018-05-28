//
//  ReceiveViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/5.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//  接收

import UIKit
import UIKit
import CoreImage
import MBProgressHUD
import RxSwift
import RxCocoa

class ReceiveViewController: UIViewController {

    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var codeImageView: UIImageView!
    let disposeBag = DisposeBag()
    var addressString: String = "" {
        didSet {
            addressLabel.text = addressString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipLabel.text = R.string.tron.balanceReceiveAddressTip()
    
        copyButton.setTitle(R.string.tron.balanceReceiveButtonCopy(), for: .normal)
        ServiceHelper.shared.account.asObservable()
            .subscribe(onNext: {[weak self] (account) in
                if let address = account?.address.addressString {
                    self?.addressString = address
                    self?.changeQRCode(address: address)
                }
            })
        .disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    
    func changeQRCode(address: String) {
        let string = address
        
        // EIP67 format not being used much yet, use hex value for now
        // let string = "ethereum:\(account.address.address)?value=\(value)"
        
        DispatchQueue.global(qos: .background).async {
            let image = self.generateQRCode(from: string)
            DispatchQueue.main.async {
                self.codeImageView.image = image
            }
        }
    }
    
    @IBAction func copyButtonClick(_ sender: Any) {
        self.copyAddress()
    }
    
    @objc func copyAddress() {
        UIPasteboard.general.string = addressString
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = R.string.tron.hudCopysuccess()
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 7, y: 7)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }

}
