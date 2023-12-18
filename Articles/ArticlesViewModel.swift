//
//  ArticlesViewModel.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import UIKit

class ArticlesViewModel {
    var networkManager: NetworkManager
    
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getData(screenType: ScreenType) {
        networkManager.doRequest(type: screenType) { result in
            print(result)
        }
    }
}
 
