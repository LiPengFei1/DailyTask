//
//  PFTaskCollectionViewCell.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/10.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit

class PFTaskCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addAnimationToShapeLayer(layer:CAShapeLayer,keyPath:String,fromValue:CGFloat,toValue:CGFloat,duration:TimeInterval){
        
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = duration; //动画时间
        animation.fromValue = fromValue
        animation.toValue = toValue
        layer.add(animation, forKey: keyPath)
    }
    
    func setupUI(){
        contentView.addSubview(titleView)
        
        let path = UIBezierPath()
        let startPoint = CGPoint(x: self.bounds.origin.x , y: 44)
        let endPoint = CGPoint(x: self.bounds.origin.x + self.bounds.size.width, y: 44)
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        dottedLayer.path = path.cgPath
        dottedLayer.lineJoin = kCALineJoinRound
        let arr = NSArray(array: [1,0])
        dottedLayer.lineDashPattern = arr as? [NSNumber]
        dottedLayer.lineWidth = 2
        dottedLayer.strokeColor = UIColor(colorLiteralRed: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0).cgColor
        dottedLayer.fillColor = UIColor.clear.cgColor
        
        self.addAnimationToShapeLayer(layer: dottedLayer, keyPath: "strokeEnd", fromValue: 0, toValue: 1, duration: 0.5)
        self.layer.addSublayer(dottedLayer)
        
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.equalTo(contentView)
        }
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleView).offset(12)
            make.top.equalTo(titleView).offset(0)
            make.height.equalTo(44)
        }
        
        titleView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(titleView).offset(-12)
            make.centerY.equalTo(titleLabel).offset(0)
        }
        
        titleView.addSubview(finishBtn)
        finishBtn.snp.makeConstraints { (make) in
            make.right.equalTo(titleView).offset(-12)
            make.centerY.equalTo(titleLabel).offset(0)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        titleView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleView).offset(12)
            make.right.equalTo(titleView).offset(-12)
            make.bottom.equalTo(titleView).offset(-12)
            make.top.equalTo(titleView).offset(56)
        }
    }
    
    func clickFinish(button:UIButton){
        button.backgroundColor = UIColor.lightGray
    }
    
    //懒加载
    lazy var titleView:UIView = {
        let titleView:UIView = UIView()
//        titleView.backgroundColor = UIColor(colorLiteralRed: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        titleView.backgroundColor = UIColor.white
        return titleView
    }()
    
    lazy var titleLabel:PFLabel = {
        let label:PFLabel = PFLabel(text: "有趣的标题", font: UIFont.systemFont(ofSize: 14.0))
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    lazy var timeLabel:PFLabel = {
        let label:PFLabel = PFLabel(text: "2016.11.18", font: UIFont.systemFont(ofSize: 12.0))
        label.textColor = UIColor(white: 0, alpha: 0.4)
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    lazy var contentLabel:UILabel = {
        let label:UILabel = UILabel()
        label.text = "这里都是一些非常有意思的内容，看看有没有你喜欢的。"
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var levelView:UIView = {
        let level:UIView = UIView()
        return level
    }()
    
    lazy var finishBtn:UIButton = {
        let button:UIButton = UIButton()
        button.isHidden = true
//        button.setTitle("完成", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(clickFinish(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var dottedLayer:CAShapeLayer = {
        let lineLayer = CAShapeLayer()
        return lineLayer
    }()

}
