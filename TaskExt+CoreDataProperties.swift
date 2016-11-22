//
//  TaskExt+CoreDataProperties.swift
//  
//
//  Created by 李鹏飞 on 16/11/22.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension TaskExt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskExt> {
        return NSFetchRequest<TaskExt>(entityName: "TaskExt");
    }

    @NSManaged public var extDescription: String?
    @NSManaged public var extId: String?
    @NSManaged public var extName: String?
    @NSManaged public var levelId: String?
    @NSManaged public var finishedCount: Int32
    @NSManaged public var dailyTasks: NSSet?
    @NSManaged public var state: StateDaily?

}

// MARK: Generated accessors for dailyTasks
extension TaskExt {

    @objc(addDailyTasksObject:)
    @NSManaged public func addToDailyTasks(_ value: DailyTask)

    @objc(removeDailyTasksObject:)
    @NSManaged public func removeFromDailyTasks(_ value: DailyTask)

    @objc(addDailyTasks:)
    @NSManaged public func addToDailyTasks(_ values: NSSet)

    @objc(removeDailyTasks:)
    @NSManaged public func removeFromDailyTasks(_ values: NSSet)

}
