//
//  PFLabel.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/17.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit

class PFLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text:String,font:UIFont){
        self.init()
        self.text = text
        self.font = font
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
