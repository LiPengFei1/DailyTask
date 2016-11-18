//
//  TaskExt(ext).swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/18.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import Foundation
import UIKit
import CoreData
extension TaskExt{
    //    @NSManaged public var extId: String?
    //    @NSManaged public var extName: String?
    //    @NSManaged public var levelId: String?
    //    @NSManaged public var extDescription: String?
    //    @NSManaged public var relationship: TaskDaily?
    
    // 初始化 一个新的TaskExt
    
    static func newTaskExt() ->TaskExt{
        let task:TaskExt = NSEntityDescription.insertNewObject(forEntityName: "TaskExt", into: context) as! TaskExt
        return task
    }
    // 插入数据
    func insertTaskExtToData() ->Bool{
        // 根据时间自动生成extId
        self.extId = self.getId()
        // 创建一个新的任务的同时 也为这个任务创建一个状态
        let state = NSEntityDescription.insertNewObject(forEntityName: "StateDaily", into: context) as! StateDaily
        state.isDone = false
        state.taskId = self.extId
        state.create_date = NSDate()
        self.state = state
        do{
            try context.save()
            return true
            //success
        }catch let error{
            print(error)
            return false
        }
        
        // 存
        //        let task:TaskExt = NSEntityDescription.insertNewObject(forEntityName: "TaskExt", into: context) as! TaskExt
        //        task.extId = "kkk"
        //        task.extName = "123123"
        
//        let taskDaily = NSEntityDescription.insertNewObject(forEntityName: "DailyTask", into: context) as! DailyTask
//        taskDaily.extId = self.extId
//                taskDaily.content = "测试新建任务"
//                taskDaily.create_Time = NSDate()
//                taskDaily.taskId = "123123"
//                taskDaily.taskName = "新建任务"
//        
//        self.addToDailyTasks(taskDaily)
    }
    // 查询任务
    func searchTaskExtById(extId:String){
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
        request.entity = NSEntityDescription.entity(forEntityName: "TaskExt", in: context)
        request.predicate = NSPredicate(format:"extId=\(extId)")
        var taskExt:[NSManagedObject] = []
        
        do{
            taskExt = try context.fetch(request) as! [NSManagedObject]
            for task in taskExt as! [TaskExt]{
                print(task.dailyTasks!)
            }
            
            
        }catch let error{
            print(error)
        }
    }
    
    // 根据时间生成id
    func getId() -> String{
        let date:NSDate = NSDate()
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "yyyyMMddHHmmss"
        let dateString = timeFormat.string(from: date as Date)
        var identification = "10000"
        identification.append(dateString)
        print(identification)
        return identification
    }
}
