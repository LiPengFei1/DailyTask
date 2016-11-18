//
//  PFBaseNavigationController.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/8.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit

class PFBaseNavigationController: UINavigationController {

    // 修改导航条标题的样式
    override func loadView() {
        super.loadView()
        let navBar = UINavigationBar.appearance()
    
        // 设置字体样式
        let attributes = NSMutableDictionary()
        attributes.setObject(UIFont.systemFont(ofSize: 16.0), forKey: NSFontAttributeName as NSCopying)
        attributes.setObject(UIColor.gray, forKey: NSForegroundColorAttributeName as NSCopying)
        navBar.titleTextAttributes = attributes.copy() as? [String : AnyObject]
        
        // 绘制图片
        let rect = CGRect(x: 0, y: 0, width: 10, height: 10)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(BGCOLOR.cgColor)
        context?.fill(rect)
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navBar.setBackgroundImage(img, for: .any, barMetrics: .default)
        //去掉导航下面的线
        navBar.shadowImage = UIImage()
    }
}
