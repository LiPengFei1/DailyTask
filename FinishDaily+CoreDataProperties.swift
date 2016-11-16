//
//  FinishDaily+CoreDataProperties.swift
//  
//
//  Created by 李鹏飞 on 16/11/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FinishDaily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FinishDaily> {
        return NSFetchRequest<FinishDaily>(entityName: "FinishDaily");
    }

    @NSManaged public var taskId: String?
    @NSManaged public var finish_Time: NSDate?
    @NSManaged public var isDone: Bool

}
