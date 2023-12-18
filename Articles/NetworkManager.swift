//
//  NetworkManager.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import UIKit
import Alamofire

enum ScreenType {
    case home
    case business
    case sport
}

class NetworkManager {
    var url = ""
    
    func doRequest(type: ScreenType, completion: @escaping(ArticlesModel) -> ()) {
        
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
    
    
    func parseJSON(withData data: Data, completion: @escaping(ArticlesModel) -> () ){
        let decoder = JSONDecoder()
        
        do {
            let articles = try decoder.decode(ArticlesModel.self, from: data)
            completion(articles)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
}

class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    
    private var imageCache: NSCache<NSString, UIImage>?
    
    init(urlString: String?) {
        loadImage(urlString: urlString)
    }
    
    private func loadImage(urlString: String?) {
        
        var customUrl = "https://developer.apple.com/news/images/og/swiftui-og.png"
        
        guard var urlString = urlString else { return }
        if urlString == "" {
            urlString = customUrl
        }
        if let imageFromCache = getImageFromCache(from: urlString) {
            self.image = imageFromCache
            return
        }
        
        loadImageFromURL(urlString: urlString)
    }
    
    private func loadImageFromURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        _ = AF.request(url).validate()
            .response { response  in
                guard let data = response.data else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let loadedImage = UIImage(data: data) else { return }
                    print(url)
                    self?.image = loadedImage
                    self?.setImageCache(image: loadedImage, key: urlString)
                }
            }
    }
    
    private func setImageCache(image: UIImage, key: String) {
        imageCache?.setObject(image, forKey: key as NSString)
    }
    
    private func getImageFromCache(from key: String) -> UIImage? {
        return imageCache?.object(forKey: key as NSString) as? UIImage
    }
}
