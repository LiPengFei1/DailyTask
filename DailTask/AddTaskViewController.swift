//
//  AddTaskViewController.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/17.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BGCOLOR
        self.setupUI()
        
    }

    func setupUI(){
        view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(114)
            make.left.equalTo(view).offset(12)
            make.right.equalTo(view).offset(-12)
            make.bottom.equalTo(view).offset(-114)
        }
        
        let titleLabel = PFLabel(text: "标    题:", font: UIFont.systemFont(ofSize: 14.0))
        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgView).offset(15)
            make.left.equalTo(bgView).offset(12)
        }
        
        bgView.addSubview(titleField)
        titleField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalTo(bgView).offset(12)
            make.right.equalTo(bgView).offset(-12)
            make.height.equalTo(44)
        }
        
        let contentLabel = PFLabel(text: "内    容:", font: UIFont.systemFont(ofSize: 14.0))
        bgView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleField.snp.bottom).offset(12)
            make.left.equalTo(bgView).offset(12)
        }
        
        bgView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(12)
            make.left.equalTo(bgView).offset(12)
            make.right.equalTo(bgView).offset(-12)
            make.bottom.equalTo(bgView).offset(-12)
        }
        
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(12)
            make.right.equalTo(view).offset(-12)
            make.top.equalTo(bgView.snp.bottom).offset(24)
            make.height.equalTo(44)
        }
    }
    
    func saveTask(){
        let taskExt = TaskExt.newTaskExt()
        taskExt.extName = self.titleField.text?.trimmingCharacters(in: CharacterSet())
        taskExt.extDescription = self.contentView.text.trimmingCharacters(in: CharacterSet())
        let b = taskExt.insertTaskExtToData()
        if b {
            print("保存成功")
        }else{
            print("保存失败")
        }
    }

    lazy var bgView:UIView = {
        let bgV = UIView()
        bgV.backgroundColor = viewBGCOLOR
        bgV.layer.cornerRadius = 3.0
        bgV.layer.masksToBounds = true
        return bgV
    }()
    
    lazy var titleField:UITextField = {
        let textField:UITextField = UITextField()
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.placeholder = "请输入标题"
        return textField
    }()
    
    lazy var contentView:UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = BGCOLOR.cgColor
        textView.layer.borderWidth = 2.0
        return textView
    }()
    
    lazy var commitButton:UIButton = {
        let btn:UIButton = UIButton()
        btn.backgroundColor = UIColor(colorLiteralRed: 244.0 / 255.0 , green: 121.0 / 255.0, blue: 32.0 / 255.0, alpha: 1.0)
        btn.setTitle("保    存", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 3.0
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        return btn
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
