//
//  Level+CoreDataProperties.swift
//  
//
//  Created by 李鹏飞 on 16/11/22.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Level {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Level> {
        return NSFetchRequest<Level>(entityName: "Level");
    }

    @NSManaged public var levelId: String?
    @NSManaged public var levelName: String?

}
