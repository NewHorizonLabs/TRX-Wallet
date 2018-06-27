//
//  InputNodeViewController.swift
//  TRXWallet
//
//  Created by 彭显鹤 on 2018/6/24.
//  Copyright © 2018年 newborntown. All rights reserved.
//

import UIKit

class InputNodeViewController: UIViewController {

    @IBOutlet weak var solidityNodeView: NodeInputView!
    @IBOutlet weak var fullNodeView: NodeInputView!
    override func viewDidLoad() {
        super.viewDidLoad()
        solidityNodeView.nodeType = .solidity
        fullNodeView.nodeType = .full
        // Do any additional setup after loading the view.
    }
    

}
