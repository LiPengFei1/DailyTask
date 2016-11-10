//
//  HomePageController.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/8.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit

class HomePageController: PFBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //var collectionView:UICollectionView? = nil
    
    // flowLayout
    lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        // 方向
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        let width:CGFloat = self.view.frame.size.width - 6
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumLineSpacing = 5 // 上下间距
        layout.minimumInteritemSpacing = 0 //左右间距
        layout.headerReferenceSize = CGSize(width: 375, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return layout
    }()
    
    // collectionView
    lazy var collectionView:UICollectionView = {
        var  frame:CGRect = self.view.bounds
        //frame.size.width -= 20
        //frame.origin.x = 10
        let collection:UICollectionView = UICollectionView(frame:frame, collectionViewLayout: self.layout)
        collection.backgroundColor = UIColor(colorLiteralRed: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBarButton()
        view.addSubview(collectionView)
        collectionView.register(PFTaskCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "ID")
        collectionView.register(CollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head")
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
        return 15
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 365, height: 200)
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head", for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       let  item = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath)
        item.layer.cornerRadius = 3.0
        item.layer.masksToBounds = true
//        item.layer.borderColor = UIColor.lightGray.cgColor
//        item.layer.borderWidth = 1
        return item
    }
    
    func addNewTask(){
        print("添加新任务")
    }
}
