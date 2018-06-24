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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
