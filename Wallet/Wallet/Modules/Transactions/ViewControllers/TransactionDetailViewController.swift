//
//  TransactionDetailViewController.swift
//  TRXWallet
//
//  Created by Maynard on 2018/7/18.
//  Copyright © 2018年 newborntown. All rights reserved.
//

import UIKit
import MBProgressHUD

class TransactionDetailViewController: UIViewController {
    
    @IBOutlet weak var toAddressLabel: UILabel!
    @IBOutlet weak var fromAddressLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var transactionIDLabel: WebsiteLabel!
    @IBOutlet weak var codeImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    var transaction: TransactionModel?
    
    var url: String = "" {
        didSet {
            transactionIDLabel.url = URL(string: url)
            changeQRCode(address: url)
        }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.backgroundColor
        if let transaction = transaction {
            configure(model: transaction)
            if let idStirng  = transaction.hashString {
                print(idStirng)
                let str1 = NSMutableAttributedString(string: idStirng)
                let range1 = NSRange(location: 0, length: str1.length)
                let number = NSNumber(value:NSUnderlineStyle.styleSingle.rawValue)
                str1.addAttribute(NSAttributedStringKey.underlineStyle, value: number, range: range1)
                transactionIDLabel.attributedText = str1
                url = "https://tronscan.org/#/transaction/\(idStirng)"
            }
            
        }
    }
    
    @IBAction func copyButtonClick(_ sender: Any) {
        self.copyAddress()
    }
    
    @objc func copyAddress() {
        UIPasteboard.general.string = url
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = R.string.tron.hudCopysuccess()
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    func configure(model: TransactionModel) {
        dateLabel.text = model.timestamp?.dateString
        self.fromAddressLabel.text = model.ownerAddress
        self.toAddressLabel.text = model.toAddress
        guard let value = model.contractData?.amount else {
            return
        }
        if let token = model.contractData?.token {
            self.valueLabel.text = "\(value.toString() ?? "0")" + " \(token)"
        } else {
            self.valueLabel.text = "\(value.trxValue.toString() ?? "0")" + " TRX"
        }
        
    }

}
