//
//  NetworkManager.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import Foundation
import Alamofire

enum ScreenType {
    case home
    case business
    case sport
}


class NetworkManager {
    var url = ""
    
    func doRequest(type: ScreenType, completion: @escaping(Result<ArticlesModel, Error>) -> ()) {
        
        switch type {
        case .home:
            url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=30bab526ed854fdc815c2aa02f19a53e"
        case .business:
            url = "https://newsapi.org/v2/top-headlines?category=business&apiKey=30bab526ed854fdc815c2aa02f19a53e"
        case .sport:
            url = "https://newsapi.org/v2/top-headlines?category=sports&apiKey=30bab526ed854fdc815c2aa02f19a53e"
        }
        
        guard let url = URL(string: url) else { return }
        
        _ = AF.request(url).validate()
            .response { response  in
                guard let data = response.data else { return }
                self.parseJSON(withData: data, completion: completion)
                
            }
    }
    
    
    func parseJSON(withData data: Data, completion: @escaping(Result<ArticlesModel, Error>) -> () ){
        
        let decoder = JSONDecoder()
        
        do {
            let articles = try decoder.decode(ArticlesModel.self, from: data)
            completion(.success(articles))
            print(articles)
        } catch let error as NSError{
            print("Its error")
            print(error)
        }
    }
}

