//
//  CollectionReusableView.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/10.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit
import SnapKit

class CollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.orange
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
    }
    
    lazy var imageView:UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "sea")
        return imgView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
