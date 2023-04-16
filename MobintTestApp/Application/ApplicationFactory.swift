//
//  ApplicationFactory.swift
//  MobintTestApp
//
//  Created by Evgenii Mikhailov on 16.04.2023.
//

import Foundation

final class ApplicationFactory {
    
    
    let networkService: NetworkServiceProtocol
    
    var mainViewModel: MainViewModelProtocol {
        return MainViewModel(networkService: networkService)
    }
    
    init() {
        self.networkService = NetworkService()
    }
}
