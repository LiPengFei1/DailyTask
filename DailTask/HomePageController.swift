//
//  HomePageController.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/8.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit
import CoreData

class HomePageController: PFBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    // flowLayout
    lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        // 方向
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        let width:CGFloat = (self.view.frame.size.width - 24)
        layout.itemSize = CGSize(width: width , height: width / 3)
        layout.minimumLineSpacing = 10 // 上下间距
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
        collection.backgroundColor = BGCOLOR
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
        
        
        
        // 使用本地data文件
//        let model:NSManagedObjectModel = NSManagedObjectModel.mergedModel(from: nil)!
//        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
//        let docs:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
//        let url:NSURL = NSURL(fileURLWithPath: docs.appending("/DailTask.data"))
//        print(url)
//        let error:Error? = nil
//        let store = try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url as URL, options: nil)
//        let context = NSManagedObjectContext()
//        context.persistentStoreCoordinator = psc
        
        // 上下文
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 存
        let task:TaskExt = NSEntityDescription.insertNewObject(forEntityName: "TaskExt", into: context) as! TaskExt
        task.extId = "kkk"
        task.extName = "123123"
        let taskDaily = NSEntityDescription.insertNewObject(forEntityName: "TaskDaily", into: context) as! TaskDaily
        taskDaily.extId = "kkk"
        taskDaily.content = "hhf2lkva"
        taskDaily.create_Time = NSDate()
        taskDaily.taskId = "1231"
        taskDaily.taskName = "k"
        try! context.save()
        
        // 取
        let fetRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
        fetRequest.entity = NSEntityDescription.entity(forEntityName: "TaskExt", in: context)
//        let objects = try! context.execute(fetRequest) as! [NSManagedObject]
        var objects:[NSManagedObject] = []
        do{
            objects = try context.fetch(fetRequest) as! [NSManagedObject]

        }catch let error{
            print(error)
        }
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
        request.entity = NSEntityDescription.entity(forEntityName: "TaskDaily", in: context)
        do{
            let obj = try context.fetch(request) as! [NSManagedObject]
            for task in obj as! [TaskDaily]{
                print("taskName = \(task.taskName)")
            }
            for task in objects as! [TaskExt]{
                print("id = \(task.extId)")
            }
        }catch let error{
            print(error)
        }
    }
    
    //使用coredata
    func setNavBarButton(){
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage(named: "tianjiashouhuodizhi"), for: UIControlState())
        btn.setTitleColor(UIColor.gray, for: UIControlState())
        btn.setTitle(" 添加任务", for: .normal)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath = (\(indexPath.section),\(indexPath.row))")
        
        let childController = HomePageController()
        self.navigationController?.pushViewController(childController, animated: true)
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
        let taskContrller = AddTaskViewController()
        taskContrller.title = "添加"
        self.navigationController?.pushViewController(taskContrller, animated: true)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
//        if scrollView.contentOffset.y > -64 {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        }else if scrollView.contentOffset.y <= -64{
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }
}
