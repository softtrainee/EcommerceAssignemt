//
//  ProductListLocalDataManager.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//
import CoreData

class ProductListLocalDataManager:ProductListLocalDataManagerInputProtocol {
    
    func retrieveProductList() throws -> [Product]  {
        
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<Product> = NSFetchRequest(entityName: String(describing: Product.self))
        
        return try managedOC.fetch(request)
    }
    
    func saveProduct(id: Int, title: String, imageUrl: String, thumbImageUrl: String) throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newProduct = NSEntityDescription.entity(forEntityName: "Product",
                                                           in: managedOC) {
            let product = Product(entity: newProduct, insertInto: managedOC)
            product.id = Int32(id)
            product.title = title
            product.imageUrl = imageUrl
            product.thumbImageUrl = thumbImageUrl
            try managedOC.save()
        }
        throw PersistenceError.couldNotSaveObject
    
    }
    
}
