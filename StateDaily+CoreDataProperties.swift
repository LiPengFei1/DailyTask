//
//  StateDaily+CoreDataProperties.swift
//  
//
//  Created by 李鹏飞 on 16/11/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension StateDaily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StateDaily> {
        return NSFetchRequest<StateDaily>(entityName: "StateDaily");
    }

    @NSManaged public var finish_date: NSDate?
    @NSManaged public var isDone: Bool
    @NSManaged public var taskId: String?
    @NSManaged public var create_date: NSDate?
    @NSManaged public var state: TaskExt?

}
