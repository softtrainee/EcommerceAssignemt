//
//  LocalDataManager.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import CoreData

class LoginViewLocalDataManager: LoginViewLocalDataManagerInputProtocol{
    
    static func reteriveUser() throws -> User? {
        guard let managedObjectContext = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<User> = NSFetchRequest(entityName: String(describing: User.self))
        
        do{
            return try managedObjectContext.fetch(request).first
        }catch{
            throw PersistenceError.objectNotFound
        }
    }
    
    func saveUser(token: String, userData: UserData) throws {
        guard let managedObjectContext = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newUser = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext){
            let user = User(entity: newUser, insertInto: managedObjectContext)
            user.id = Int32(userData.id ?? 0)
            user.firstName = userData.firstName
            user.lastName = userData.lastName
            user.email = userData.email
            user.phone = userData.phone
            user.gender = userData.gender
            user.token = token
            
            do {
                try managedObjectContext.save()
            } catch{
                throw PersistenceError.couldNotSaveObject
            }
        }
    }
    
}
