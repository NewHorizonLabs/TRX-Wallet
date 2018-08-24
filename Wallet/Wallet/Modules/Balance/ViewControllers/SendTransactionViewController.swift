//
//  SendViewController.swift
//  Wallet
//
//  Created by Maynard on 2018/5/5.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import Eureka
import JSONRPCKit
import APIKit
import BigInt
import QRCodeReaderViewController
import TrustCore
import TrustKeystore
import RxSwift
import RxCocoa

class SendTransactionViewController: UIViewController {

    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextView!
    @IBOutlet weak var pasteButton: UIButton!
    
    @IBOutlet weak var numberTipLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    let disposeBag = DisposeBag()
    
    var asset: AccountAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addressTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        tipLabel.text = R.string.tron.balanceSendAddressLabelTitle()
        numberTipLabel.text = R.string.tron.balanceSendNumberLabelTitle()
        nextButton.setTitle(R.string.tron.balanceSendNextButtonTitle(), for: .normal)
        pasteButton.setTitle(R.string.tron.balanceSendPasteButtonTitle(), for: .normal)
        
        nameButton.setTitleColor(UIColor(hex: "666666"), for: .normal)
        nameButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        pasteButton.setTitleColor(UIColor(hex: "#333333"), for: .normal)
        
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.setTitleColor(UIColor.disabledTextColor, for: .disabled)
        nextButton.setBackgroundColor(UIColor.mainNormalColor, forState: .normal)
        nextButton.setBackgroundColor(UIColor.disabledBackgroundColor, forState: .disabled)
        
        scanButton.pborderWidth = 0.5
        scanButton.pborderColor = UIColor.mainNormalColor
        scanButton.pcornerRadius = 2
        
        pasteButton.addTarget(self, action: #selector(pasteButtonClick), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
        
        if let asset = asset {
            title = "\(asset.balance) \(asset.name)"
            nameButton.setTitle(asset.name, for: .normal)
        } else {
            nameButton.setTitle("TRX", for: .normal)
            title = "TRX"
        }
        
        Observable.combineLatest(addressTextField.rx.text.orEmpty.map{ return $0.count > 0 }, numberTextField.rx.text.orEmpty.map{ return $0.count > 0 }) { (a, b) -> Bool in
            return a && b
        }.bind(to: nextButton.rx.isEnabled)
        .disposed(by: disposeBag)
    
    }
    
    @objc func pasteButtonClick() {
        self.addressTextField.text = UIPasteboard.general.string
    }
    
    @IBAction func tapNumber(_ sender: Any) {
        self.numberTextField.becomeFirstResponder()
    }
    @IBAction func tapAddress(_ sender: Any) {
        self.addressTextField.becomeFirstResponder()
    }
    @objc func nextButtonClick() {
        guard let account = ServiceHelper.shared.account.value, let addressData = Data(base58CheckDecoding: addressTextField.text ?? ""), let numberText = numberTextField.text, let number = numberText.cgFloat else {
            return
        }
        
        self.view.endEditing(true)
        let vc = R.storyboard.balance.sendConfiremViewController()!
        self.navigationController?.pushViewController(vc, animated: true)
        vc.info = (account.address.addressString, addressTextField.text!, number)
        vc.asset = asset
        if let asset = asset {
            vc.title = "\(asset.name)"
        } else {
            vc.title = "TRX"
        }
        
        
    }
    
    @IBAction func scanButtonClick(_ sender: Any) {
        openReader()
    }
    
    @objc func openReader() {
        let controller = QRCodeReaderViewController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
}

extension SendTransactionViewController: QRCodeReaderDelegate {
    func readerDidCancel(_ reader: QRCodeReaderViewController!) {
        reader.stopScanning()
        reader.dismiss(animated: true, completion: nil)
    }
    func reader(_ reader: QRCodeReaderViewController!, didScanResult result: String!) {
        reader.stopScanning()
        reader.dismiss(animated: true, completion: nil)
        if result == nil {
            HUD.showText(text: "Error QRCode")
            return
        }
        if let address = result.components(separatedBy: "to=").last {
            self.addressTextField.text = address
        }
        
    }
}

extension String {
    var cgFloat: CGFloat? {
        if let value = NumberFormatter().number(from: self)?.floatValue {
            return CGFloat(value)
        }
        return nil
    }
}
