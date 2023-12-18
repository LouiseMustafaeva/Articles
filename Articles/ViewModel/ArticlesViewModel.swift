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
//                self.deleteAll(items: items, viewContext: viewContext)
            DispatchQueue.main.async {
                for article in result.articles ?? [] {
                    let newItem = Item(context: viewContext)
                    newItem.title = article.title
                    newItem.subTitle = article.description
                    newItem.imageUrl = article.urlToImage
                    newItem.author = article.author
                    newItem.date = article.publishedAt
                    
                    if !items.contains(where: {$0.title == newItem.title}) {
                        do {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.localizedDescription)")
                        }
                    } else {
                        viewContext.delete(newItem)
                        do {
                            try viewContext.save()
                        } catch {
                            let error = error as Error
                            fatalError("Unresolved error \(error), \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
    
    func deleteAll(items: FetchedResults<Item>, viewContext: NSManagedObjectContext) {
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
    
    func getDataFromNetwork(screenType: ScreenType) {
        networkManager.doRequest(type: screenType) { result in
            if screenType == .sport {
                for article in result.articles ?? [] {
                    if !self.sportNews.contains(article) {
                        self.sportNews.append(article)
                    }
                }
            } else {
                for article in result.articles ?? [] {
                    if !self.businessNews.contains(article) {
                        self.businessNews.append(article)
                    }
                }
            }
        }
    }
}
