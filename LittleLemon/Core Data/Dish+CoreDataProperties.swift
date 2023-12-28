//
//  Dish+CoreDataProperties.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Float

    private static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }
    
    static func with(name: String,
                     _ context:NSManagedObjectContext) -> Dish? {
        let request = Dish.request()
        
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "name",
                                              ascending: false,
                                              selector: #selector(NSString .localizedStandardCompare))
        request.sortDescriptors = [sortDescriptor]
        
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count == 1,
                  let dish = results.first
            else { return Dish(context: context) }
            return dish
        } catch (let error){
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func exists(name: String,
                       _ context:NSManagedObjectContext) -> Bool? {
        let request = Dish.request()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", name)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return nil
            }
            return results.count > 0
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
    class func deleteAll(_ context:NSManagedObjectContext) {
        let request = Dish.request()
        do {

            let deleteResult = try context.execute(request) as? NSBatchDeleteResult
            
            // Extract the IDs of the deleted managed objectss from the request's result.
            if let objectIDs = deleteResult?.result as? [NSManagedObjectID] {
                
                // Merge the deletions into the app's managed object context.
                NSManagedObjectContext.mergeChanges(
                    fromRemoteContextSave: [NSDeletedObjectsKey: objectIDs],
                    into: [context]
                )
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}

extension Dish {
    static func createDishesFrom(menuItems: [MenuItem],_ context: NSManagedObjectContext) {
        
        for menuItem in menuItems {
            let exist = Dish.exists(name: menuItem.title, context) ?? false
            
            if !exist {
                let newDish = Dish(context: context)
                newDish.title = menuItem.title
                //newDish.description = menuItem.description
                newDish.image = menuItem.image
                if let price = Float(menuItem.price) {
                    newDish.price = price
                }
            }
        }
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
}


extension Dish : Identifiable {

}


