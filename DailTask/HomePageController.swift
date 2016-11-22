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
        NotificationCenter.default.addObserver(self, selector: #selector(loadNewData), name: NSNotification.Name(rawValue: "loadNewDataSource"), object: nil)
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
    func loadNewData(){
        if isPush {
            self.loadDataByTaskExtId(taskId: taskExtId)
        }else{
            self.loadData()
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
        item.layer.borderColor = UIColor.orange.cgColor
        item.layer.borderWidth = 0.2
        item.alpha = 0.9
        
        item.indexPath = indexPath
        item.finishedBlock = { (btn,indexPath) in
            self.finishedTask(btn: btn,indexPath: indexPath)
        }
        var date:NSDate = NSDate()
        if isPush {
            let dailyTask:DailyTask = taskArray![indexPath.row] as! DailyTask
            item.titleLabel.text = dailyTask.taskName
            if ((dailyTask.state?.create_date) != nil) {
                if dailyTask.state!.isDone{
                    item.finishBtn.backgroundColor = UIColor.gray
                }else{
                    item.finishBtn.backgroundColor = UIColor.orange
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
                }else{
                    item.finishBtn.backgroundColor = UIColor.orange
                }
            }
            
            if taskExt.dailyTasks!.count > 0 {
                item.countLabel.text = "\(taskExt.finishedCount)/\(taskExt.dailyTasks!.count)"
            }else{
                item.countLabel.text = ""
            }
        }
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "yyyy.MM.dd"
        let dateString = timeFormat.string(from: date as Date)
        item.timeLabel.text = dateString
        return item
    }
    func finishedTask(btn:UIButton,indexPath:IndexPath){
        //完成任务
        //1.获取任务ID 知道是哪个任务完成了
        if isPush{
            let dailyTask:DailyTask = self.taskArray![indexPath.row] as! DailyTask
            dailyTask.state?.finish_date = NSDate()
            dailyTask.state?.isDone = true
            dailyTask.taskExt?.finishedCount += 1
            let taskExt:TaskExt = dailyTask.taskExt!
            if intmax_t( taskExt.finishedCount) == taskExt.dailyTasks!.count {
                //说明任务全部完成了
                taskExt.state?.finish_date = NSDate()
                taskExt.state?.isDone = true
            }
            do{
                try context.save()
                btn.backgroundColor = UIColor.gray
                // 发送一条通知,更新首页数据
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadNewDataSource"), object: nil)
            }catch let error{
                print(error)
            }
        }else{
            //完成任务之前 先检查子任务是否都完成，如果全部完成，才能完成这个任务
            let taskExt:TaskExt = self.taskArray![indexPath.row] as! TaskExt
            if taskExt.dailyTasks!.count == intmax_t(taskExt.finishedCount)
            {
                taskExt.state?.finish_date = NSDate()
                taskExt.state?.isDone = true
                btn.backgroundColor = UIColor.gray
                do{
                    try context.save()
                }catch let error{
                    print(error)
                }
            }else{
                //提示未完成子任务连接
                print("请先完成子任务")
            }
        }
        //3.刷新数据
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 365, height: 200)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isPush {
            
        }else{
            let taskExt:TaskExt = taskArray![indexPath.row] as! TaskExt
            let childController:HomePageController = HomePageController()
            childController.isPush = true
            childController.taskExtId = taskExt.extId!
            childController.taskExt = taskExt
            childController.title = "目标"
                self.navigationController?.pushViewController(childController, animated: true)
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
        layout.itemSize = CGSize(width: width , height: width / 3 + 22)
        layout.minimumLineSpacing = 10 // 上下间距
        layout.minimumInteritemSpacing = 0 //左右间距
        layout.headerReferenceSize = CGSize(width: 375, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
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
//        collection.contentSize = self.view.bounds.size
        collection.delegate = self
        collection.dataSource = self
        collection.bounces = true
        // 当界面内容不超过界面大小时不会滑动，加上面这句话就能滑动了 
        collection.alwaysBounceVertical = true
        collection.backgroundView = UIImageView(image: UIImage(named: "sea"))
        return collection
        
    }()
}
