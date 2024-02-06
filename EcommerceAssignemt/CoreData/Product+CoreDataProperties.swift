//
//  Product+CoreDataProperties.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product");
    }

    @NSManaged public var thumbImageUrl: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int32
    @NSManaged public var count: Int32
    @NSManaged public var price: String?
    @NSManaged public var rating: String?
    @NSManaged public override var description: String
    @NSManaged public var category: String?
    @NSManaged public var brand: String?
}
