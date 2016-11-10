//
//  PFTaskCollectionViewCell.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/10.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit
import SnapKit

class PFTaskCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.equalTo(contentView)
        }
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleView).offset(0)
            make.top.equalTo(titleView).offset(0)
            make.bottom.equalTo(titleView).offset(0)
            make.right.equalTo(titleView).offset(0)
        }
    }
    
    //懒加载
    lazy var titleView:UIView = {
        let titleView:UIView = UIView()
//        titleView.backgroundColor = UIColor(colorLiteralRed: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        titleView.backgroundColor = UIColor.white
        return titleView
    }()
    
    lazy var titleLabel:UILabel = {
        let label:UILabel = UILabel()
        label.text = "这是一个非常有意思的标题"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var finishBtn:UIButton = {
        let button:UIButton = UIButton()
        button.setTitle("完成", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.backgroundColor = UIColor.black
        return button
    }()
    

}
