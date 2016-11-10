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
        
    }
    
    lazy var imageView:UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
