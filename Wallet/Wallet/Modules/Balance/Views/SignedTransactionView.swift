//
//  SignedTransactionView.swift
//  Wallet
//
//  Created by Maynard on 2018/5/31.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignedTransactionView: UIView, XibLoadable, Popable {
    @IBOutlet weak var codeImageView: UIImageView!
    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var finishBlock: (() -> Void)?
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        (closeButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.popDismiss()
            })
            .disposed(by: disposeBag)
        
        (finishButton.rx.tap).debounce(0.5, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.finishBlock?()
                self?.popDismiss()
            })
            .disposed(by: disposeBag)
    }
    
    func changeQRCode(address: String) {
        let dataString = address
        // EIP67 format not being used much yet, use hex value for now
        // let string = "ethereum:\(account.address.address)?value=\(value)"
        
        DispatchQueue.global(qos: .background).async {
            let image = self.generateQRCode(from: dataString)
            DispatchQueue.main.async {
                self.codeImageView.image = image
            }
        }
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
