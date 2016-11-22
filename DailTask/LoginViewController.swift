//
//  LoginViewController.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/22.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view).offset(0)
            make.centerY.equalTo(view).offset(0)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
    }
    
    func clickLogin(){
        let myContext = LAContext()
        let error:Error? = nil
        if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: error as! NSErrorPointer) {
            myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "按手印吧", reply: { (success, err) in
                if success{
                    // 记录登录信息j
                    self.saveLoginMessage()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeRootViewController"), object: nil)
                }else{
                    print(err as Any)
                }
            })
        }else{
            print(error as Any)
        }
    }
    
    func saveLoginMessage(){
        
    }
    

    lazy var loginBtn:UIButton = {
        let button = UIButton()
        button.setTitle("使用指纹登录", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(clickLogin), for: .touchUpInside)
        return button
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
