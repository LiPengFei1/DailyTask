//
//  AddTaskViewController.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/17.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var taskExtId = ""
    var taskExt:TaskExt?
    var isRepeat:Bool = true
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
            make.top.equalTo(view).offset(24)
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
        
        bgView.addSubview(repeatButton)
        repeatButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleField.snp.bottom).offset(12)
            make.left.equalTo(titleField.snp.left).offset(0)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        let contentLabel = PFLabel(text: "内    容:", font: UIFont.systemFont(ofSize: 14.0))
        bgView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(repeatButton.snp.bottom).offset(12)
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
        // 验证是否为空
        let name = self.titleField.text?.trimmingCharacters(in: CharacterSet())
        let content = self.contentView.text.trimmingCharacters(in: CharacterSet())
        
        if taskExtId.isEmpty {
            if !(name?.isEmpty)! && !content.isEmpty  {
                let taskExt = TaskExt.newTaskExt()
                taskExt.extName = name
                taskExt.extDescription = content
                taskExt.finishedCount = 0
                let b = taskExt.insertTaskExtToData(name: name!, descript: content, isRepeat: isRepeat)
                if b {
                    print("保存成功")
                }else{
                    print("保存失败")
                }
            }else{
                print("空")
            }
        }else{
            if !(name?.isEmpty)! && !content.isEmpty  {
                let taskExt = TaskExt.getTaskExtById(taskExtId: taskExtId)
//                let taskExt = self.taskExt
                let b = taskExt.insertDailyTaskToData(taskName: name!, content: content,isRepeat: isRepeat)
                if b {
                    print("保存成功")
                }else{
                    print("保存失败")
                }

            }else{
                print("空")
            }
        }
        //刷新数据
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadNewDataSource"), object: nil)
        self.navigationController!.popViewController(animated: true)
        // 提示信息
    }
    
    func chooseRepeatOrNoRepeat(btn:UIButton){
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            btn.backgroundColor = UIColor.orange
            isRepeat = true
        }else{
            btn.backgroundColor = UIColor.gray
            isRepeat = false
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
        textField.font = UIFont.systemFont(ofSize: 14.0)
        return textField
    }()
    
    lazy var contentView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14.0)
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
    
    lazy var repeatButton:UIButton = {
        let btn:UIButton = UIButton()
        btn.backgroundColor = UIColor.orange
        btn.setTitle("重复", for: .selected)
        btn.setTitle("不重复", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        btn.isSelected = true
        btn.layer.cornerRadius = 3.0
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(chooseRepeatOrNoRepeat(btn:)), for: .touchUpInside)
        return btn
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
