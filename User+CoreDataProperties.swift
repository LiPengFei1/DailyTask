//
//  User+CoreDataProperties.swift
//  
//
//  Created by 李鹏飞 on 16/11/23.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var userName: String?
    @NSManaged public var passWork: String?
    @NSManaged public var loginDate: NSDate?

}
