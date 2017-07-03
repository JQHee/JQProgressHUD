//
//  ViewController.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/6/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - private methods
    private func setupUI() {
        self.tableView.tableFooterView = UIView.init()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -  lazy load
    fileprivate var datas: [String] = ["normalHUD","customHUD","progressHUD","showImageHUD","toastHUD","hideHUD"]

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: UITableViewCell.self))
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: String.init(describing: UITableViewCell.self))
        }
        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            JQProgressHUDTool.jq_showNormalHUD(msg: "加载中...")
            break
        case 1:
            JQProgressHUDTool.jq_showCustomHUD(msg: "加载中...")
            break
        case 2:
            DispatchQueue.global().async {
                
                for i in 1...100 {
                    Thread.sleep(forTimeInterval: 0.02)
                    DispatchQueue.main.async {
                        JQProgressHUDTool.jq_showCircularHUD(msg: "加载中...", progress: CGFloat(i))
                    }
                }
                Thread.sleep(forTimeInterval: 0.1)
                DispatchQueue.main.async {
                    
                }
            }
            break
        case 3:
            JQProgressHUDTool.jq_showImageHUD( msg: "错误", imageName: "Error")
            break
        case 4:
            JQProgressHUDTool.jq_showToastHUD( msg: "我是一个toast")
            break
        case 5:
            JQProgressHUDTool.jq_hideHUD()
            break
            
        default: break
            
        }
    }
}

