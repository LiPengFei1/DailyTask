//
//  AppDelegate.swift
//  DailTask
//
//  Created by 李鹏飞 on 16/11/7.
//  Copyright © 2016年 com.lipengfei. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 1.初始化window
        self.window = UIWindow(frame:UIScreen.main.bounds)
        // 2.设置rootController
        let mainController = LoginViewController()
        self.window?.rootViewController = mainController
        self.window?.makeKeyAndVisible()
        
        // 3.初始化数据
        initTaskDataBase()
        //添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(changeRootViewController), name: NSNotification.Name(rawValue: "changeRootViewController"), object: nil)
        return true
    }
    
    func initTaskDataBase(){
        
        var loginUser:User?
        // 1.通过用户名查找用户，如果用户不存在，说明是第一次登录，创建一个用户
        let fetRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        // 查询条件
        // 注意: 查询的时候如果是字符串类型的参数需要使用单引号 ‘’
        fetRequest.predicate = NSPredicate(format: "userName = 'lipengfei'")
        // 查询结果
        var objects:[NSManagedObject] = []
        do{
            objects = try context.fetch(fetRequest) as! [NSManagedObject]
            loginUser = objects.first as? User
            self.initTask(user: loginUser!)
            print("查到了用户")
        }catch let error{
            print(error)
        }
    }
    
    func initTask(user:User){
        //查到用户登录信息，比较时间是否为同一天
        let oldDate = user.loginDate
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "yyyy.MM.dd"
        let oldDateString = timeFormat.string(from: oldDate as! Date)
        let newDateString = timeFormat.string(from: Date())
        if oldDateString == newDateString{
            // 说明是同一天
            print("登录日期是同一天,不执行任何操作")
        }else{
            print("登录日期不是同一天")
            // 重置 需要重复执行的任务
            // 1.插入所有的重复执行的任务
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskExt")
            request.predicate = NSPredicate(format: "state.repeatTask = true")
            var objects:[NSManagedObject] = []
            do{
                objects = try context.fetch(request) as! [NSManagedObject]
                for obj:TaskExt in objects as! [TaskExt] {
                    obj.finishedCount = 0
                    obj.state?.isDone = false
                    // 初始化子任务
                    for dailytask:DailyTask in obj.dailyTasks?.allObjects as! [DailyTask]{
                        dailytask.state?.isDone = false
                    }
                }
            }catch let error{
                print(error)
            }
        }
    }
    
    func changeRootViewController(){
        
        // 2.设置rootController        
        DispatchQueue.main.async {
            let mainController = HomePageController()
            let navController:PFBaseNavigationController = PFBaseNavigationController(rootViewController: mainController)
            self.window?.rootViewController = navController
            self.window?.makeKeyAndVisible()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    var enterBackground:Bool = false
    func applicationDidEnterBackground(_ application: UIApplication) {
        //进入后台的代理方法
        enterBackground = true
        DispatchQueue.main.async {
            let mainController = LoginViewController()
            //                let navController:PFBaseNavigationController = PFBaseNavigationController(rootViewController: mainController)
            self.window?.rootViewController = mainController
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // 启动程序时会调用两次
        // 从后台进入前台会调用一次
        if enterBackground {
            
            
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
           self.saveContext()
    }
    
    // MARK: - Core Data stack

    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DailTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

