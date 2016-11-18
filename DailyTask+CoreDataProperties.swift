//
//  DailyTask+CoreDataProperties.swift
//  
//
//  Created by 李鹏飞 on 16/11/18.
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
    @NSManaged public var count: Int32
    @NSManaged public var create_Time: NSDate?
    @NSManaged public var end_Time: NSDate?
    @NSManaged public var extId: String?
    @NSManaged public var taskId: String?
    @NSManaged public var taskName: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var taskExt: TaskExt?

}
