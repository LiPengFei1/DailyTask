//
//  HomePageController.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/8.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit

class HomePageController: PFBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    //var collectionView:UICollectionView? = nil
    
    
    lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        // 方向
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.itemSize = CGSize(width: 60, height: 75)
        layout.minimumLineSpacing = 10 // 上下间距
        layout.minimumInteritemSpacing = 10 //左右间距
        return layout
    }()
    
    lazy var collectionView:UICollectionView = {
        let collection:UICollectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: self.layout)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBarButton()
    }
    
    func setNavBarButton(){
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage(named: "tianjiashouhuodizhi"), for: UIControlState())
        btn.setTitleColor(UIColor.gray, for: UIControlState())
        btn.setTitle("添加任务", for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        btn.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        let barBtn = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = barBtn
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = UICollectionViewCell()
        item.backgroundColor = UIColor.gray
        return item
    }
    
    func addNewTask(){
        print("添加新任务")
    }
}
