//
//  ViewController.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/6/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //JQProgressHUDTool.jq_showHUD()
        //JQProgressHUDTool.jq_showToast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showHUDAction(_ sender: Any) {
        JQProgressHUDTool.jq_showHUD()
    }
    @IBAction func showToastAction(_ sender: Any) {
        JQProgressHUDTool.jq_showToast(msg: "测试")
    }
    @IBAction func hideHudAction(_ sender: Any) {
        JQProgressHUDTool.jq_hideHUD(animation: true)
    }

}

