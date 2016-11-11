//
//  TaskExt+CoreDataProperties.swift
//  
//
//  Created by 李鹏飞 on 16/11/11.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension TaskExt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskExt> {
        return NSFetchRequest<TaskExt>(entityName: "TaskExt");
    }

    @NSManaged public var categoryId: String?
    @NSManaged public var categoryName: String?
    @NSManaged public var relationship: TaskDaily?

}
