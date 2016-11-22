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
    
    var taskArray:Array<Any>?
    var isPush:Bool = false
    var taskExtId = ""
    var taskExt:TaskExt?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBarButton()
        view.addSubview(collectionView)
        collectionView.register(PFTaskCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "ID")
        collectionView.register(CollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head")
        if isPush {
            self.loadDataByTaskExtId(taskId: taskExtId)
        }else{
            self.loadData()
        }
    }
    
    func loadDataByTaskExtId(taskId:String){
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
        request.entity = NSEntityDescription.entity(forEntityName: "DailyTask", in: context)
        request.predicate = NSPredicate(format: "(extId = '\(taskExtId)')")
        let sort:NSSortDescriptor = NSSortDescriptor(key: "state.create_date", ascending: false)
        request.sortDescriptors = [sort]
        do{
            self.taskArray = try context.fetch(request) as! [NSManagedObject]
            self.collectionView.reloadData()
        }catch let error{
            print(error)
        }
    }
    
    // 查询数据
    func loadData(){
        // 取
        let fetRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
        // 查询 对象
        fetRequest.entity = NSEntityDescription.entity(forEntityName: "TaskExt", in: context)
        // 查询条件,不设置查询条件 会查询所有
//        fetRequest.predicate = NSPredicate(format: "state.isDone = false")
        // 按时间排序
        let sort:NSSortDescriptor = NSSortDescriptor(key: "state.create_date", ascending: false)
        fetRequest.sortDescriptors = [sort]
        // 查询结果
        do{
            self.taskArray = try context.fetch(fetRequest) as! [NSManagedObject]
            self.collectionView.reloadData()
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
        if taskArray == nil {
            return 0
        }
        return taskArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "head", for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let item:PFTaskCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath) as! PFTaskCollectionViewCell
        item.layer.cornerRadius = 3.0
        item.layer.masksToBounds = true
        item.indexPath = indexPath
        item.finishedBlock = { (indexPath) in
            self.finishedTask(indexPath: indexPath)
        }
        var date:NSDate = NSDate()
        if isPush {
            let dailyTask:DailyTask = taskArray![indexPath.row] as! DailyTask
            item.titleLabel.text = dailyTask.taskName
            if ((dailyTask.state?.create_date) != nil) {
                if dailyTask.state!.isDone{
                    item.finishBtn.backgroundColor = UIColor.gray
                }
            }
            item.contentLabel.text = dailyTask.content
        }else{
            let taskExt:TaskExt = taskArray![indexPath.row] as! TaskExt
            item.titleLabel.text = taskExt.extName
            item.contentLabel.text = taskExt.extDescription
            if ((taskExt.state?.create_date) != nil) {                
                date = (taskExt.state?.create_date)!
                if taskExt.state!.isDone{
                    item.finishBtn.backgroundColor = UIColor.gray
                }
                print("indexPath.row = \(indexPath.row),BOOL  = \(taskExt.state!.isDone)")
            }
        }
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "yyyy.MM.dd"
        let dateString = timeFormat.string(from: date as Date)
        item.timeLabel.text = dateString
        return item
    }
    func finishedTask(indexPath:IndexPath){
        //完成任务
        //1.获取任务ID 知道是哪个任务完成了
        if isPush{
        }else{
            let taskExt:TaskExt = self.taskArray![indexPath.row] as! TaskExt
            taskExt.state?.finish_date = NSDate()
            taskExt.state?.isDone = true
            do{
                try context.save()
            }catch let error{
                print(error)
            }
        }
        //2.修改任务状态信息
        
        //3.刷新数据
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 365, height: 200)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isPush {
        
        }else{
            let taskExt:TaskExt = taskArray![indexPath.row] as! TaskExt
            if (taskExt.dailyTasks?.count)! > 0 {
                let childController:HomePageController = HomePageController()
                childController.isPush = true
                childController.taskExtId = taskExt.extId!
                childController.taskExt = taskExt
                self.navigationController?.pushViewController(childController, animated: true)
            }
        }
    }
    
    func addNewTask(){
        let taskContrller = AddTaskViewController()
        taskContrller.title = "添加"
        if isPush {
            taskContrller.taskExtId = taskExtId
            taskContrller.taskExt = taskExt
        }
        self.navigationController?.pushViewController(taskContrller, animated: true)
    }

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
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    // collectionView
    lazy var collectionView:UICollectionView = {
        var  frame:CGRect = self.view.bounds
        //frame.size.width -= 20
        //frame.origin.x = 10
        frame.size.height -= 64
        let collection:UICollectionView = UICollectionView(frame:frame, collectionViewLayout: self.layout)
        collection.backgroundColor = BGCOLOR
        collection.delegate = self
        collection.dataSource = self
        collection.bounces = true
        return collection
        
    }()
}
