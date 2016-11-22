//
//  DailyTask+CoreDataProperties.swift
//  
//
//  Created by 李鹏飞 on 16/11/22.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension DailyTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyTask> {
        return NSFetchRequest<DailyTask>(entityName: "DailyTask");
    }

    @NSManaged public var content: String?
    @NSManaged public var finishedCount: Int32
    @NSManaged public var extId: String?
    @NSManaged public var taskId: String?
    @NSManaged public var taskName: String?
    @NSManaged public var taskExt: TaskExt?
    @NSManaged public var state: StateDaily?
    @NSManaged public var childTasks: NSSet?

}

// MARK: Generated accessors for childTasks
extension DailyTask {

    @objc(addChildTasksObject:)
    @NSManaged public func addToChildTasks(_ value: DailyTask)

    @objc(removeChildTasksObject:)
    @NSManaged public func removeFromChildTasks(_ value: DailyTask)

    @objc(addChildTasks:)
    @NSManaged public func addToChildTasks(_ values: NSSet)

    @objc(removeChildTasks:)
    @NSManaged public func removeFromChildTasks(_ values: NSSet)

}
