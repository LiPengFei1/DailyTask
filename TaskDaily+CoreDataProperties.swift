//
//  TaskDaily+CoreDataProperties.swift
//  
//
//  Created by 李鹏飞 on 16/11/11.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension TaskDaily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskDaily> {
        return NSFetchRequest<TaskDaily>(entityName: "TaskDaily");
    }

    @NSManaged public var categoryId: String?
    @NSManaged public var content: String?
    @NSManaged public var create_Time: NSDate?
    @NSManaged public var end_Time: NSDate?
    @NSManaged public var isDone: Bool
    @NSManaged public var taskId: String?
    @NSManaged public var taskName: String?
    @NSManaged public var relationship: TaskExt?

}
