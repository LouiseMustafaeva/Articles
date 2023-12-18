//
//  ArticlesViewModel.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import SwiftUI
import CoreData

class ArticlesViewModel: ObservableObject {
    
    private let networkManager = NetworkManager()
    @Published var businessNews = [Main]()
    @Published var sportNews = [Main]()
    
    func getData(screenType: ScreenType, items: FetchedResults<Item>, viewContext: NSManagedObjectContext) {
        networkManager.doRequest(type: screenType) { result in
            
            if screenType != .home {
                for i in items {
                    viewContext.delete(i)
                }
                do {
                    try viewContext.save()
                } catch {
                    let error = error as Error
                    fatalError("Unresolved error \(error), \(error.localizedDescription)")
                }
            }
            
            DispatchQueue.main.async {
                for article in result.articles ?? [] {
                    let newItem = Item(context: viewContext)
                    newItem.title = article.title
                    newItem.subTitle = article.content
                    newItem.imageUrl = article.urlToImage
                    
                    if !items.contains(newItem) {
                        do {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
    
    func getDataFromNetwork(screenType: ScreenType) {
        
    }
}
