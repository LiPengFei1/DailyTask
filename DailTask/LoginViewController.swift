//
//  LoginViewController.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/22.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit
import CoreData
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
        clickLogin()
    }
    
    func clickLogin(){
        let myContext = LAContext()
        let error:Error? = nil
        if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: error as! NSErrorPointer) {
            myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "按手印吧", reply: { (success, err) in
                if success{
                    // 记录登录信息
                    self.saveLoginMessage()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeRootViewController"), object: nil)
                }else{
                    print(err as Any)
                }
            })
        }else{
            print(error as Any)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeRootViewController"), object: nil)
        }
    }
    
    func saveLoginMessage(){
        var loginUser:User?
        // 1.通过用户名查找用户，如果用户不存在，说明是第一次登录，创建一个用户
        let fetRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        // 查询条件
        // 注意: 查询的时候如果是字符串类型的参数需要使用单引号 ‘’
        fetRequest.predicate = NSPredicate(format: "userName = 'lipengfei'")
        // 查询结果
        var objects:[NSManagedObject] = []
        do{
            objects = try context.fetch(fetRequest) as! [NSManagedObject]
            loginUser = objects.first as? User
            loginUser?.loginDate = NSDate()
            print("查到了用户")
        }catch let error{
            print(error)
        }

        // 2.查到用户之后，记录用户登录的时间
        if loginUser == nil {
            loginUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User
            loginUser?.loginDate = NSDate()
            loginUser?.userName = "lipengfei"
            loginUser?.passWork = "lpf"
        }
        
        do{
            try context.save()
            print("保存用户成功")
        }catch let error{
            print(error)
        }
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
