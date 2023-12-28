//
//  MenuViewModel.swift
//  LittleLemon
//
//  Created by Mohcine BELARREM on 28/12/2023.
//

import Foundation

@MainActor
class MenuViewModel: ObservableObject {
    
    @Published var menuItems = [MenuItem]()
        
//    func reload(_ coreDataContext:NSManagedObjectContext) async {
    func reload() async {
        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json") else {
            return
        }
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
            menuItems = fullMenu.items
            
            // populate Core Data
            //Dish.deleteAll(coreDataContext)
            //Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
        }
        catch {
            print(error.localizedDescription)
        }
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

