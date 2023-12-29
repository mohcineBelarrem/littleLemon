//
//  MenuViewModel.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
class MenuViewModel: ObservableObject {
    
    private let stringURL = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
    
    var sortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                    ascending: true,
                     selector:
                        #selector(NSString.localizedCaseInsensitiveCompare))]
    }
    
    func reload(_ coreDataContext:NSManagedObjectContext) async {
        //TODO: Implement fetchdata if needed
        guard let url = URL(string: stringURL) else {
            return
        }
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
            
            // populate Core Data
            Dish.deleteAll(coreDataContext)
            Dish.createDishesFrom(menuItems:fullMenu.items, coreDataContext)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func buildPredicate(with searchText: String) -> NSPredicate {
        return searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}


extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func itemsTask(with url: URL, completionHandler: @escaping (MenuList?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

