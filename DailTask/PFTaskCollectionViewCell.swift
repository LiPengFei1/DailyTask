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
        addSubview(titleView)
        
    }
    
    lazy var titleView:UIView = {
        let titleView:UIView = UIView()
        titleView.backgroundColor = UIColor(colorLiteralRed: 200.0 / 255.0, green: 93.0 / 255.0, blue: 83.0 / 255.0, alpha: 1.0)
        return titleView
    }()
}
