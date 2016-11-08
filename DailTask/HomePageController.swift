//
//  HomePageController.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/8.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit

class HomePageController: PFBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBarButton()
    }
    
    func setNavBarButton(){
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setImage(UIImage(named: "tianjiashouhuodizhi"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btn.frame = CGRectMake(0, 0, 80, 40)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        btn.addTarget(self, action: #selector(addNewTask), forControlEvents: .TouchUpInside)
        let barBtn = UIBarButtonItem(customView: btn);
        self.navigationItem.rightBarButtonItem = barBtn
    }
    
    func addNewTask(){
        print("添加新任务")
    }
}
