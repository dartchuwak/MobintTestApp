//
//  ViewModel.swift
//  MobintTestApp
//
//  Created by Evgenii Mikhailov on 14.04.2023.
//

import Foundation



protocol MainViewModelProtocol {
    var networkService: NetworkServiceProtocol { get set }
    var items: [Item] { get }
    var isLoading: Bool { get }
    func loadData(offset: Int, completion: @escaping (NetworkError?) -> Void)
    func loadMoreDataIfNeeded(currentItem item: Item?, completion: @escaping (NetworkError?) -> Void)
}

final class MainViewModel: ObservableObject, MainViewModelProtocol {
    
    var networkService: NetworkServiceProtocol
    @Published var items: [Item] = []
    @Published var isLoading: Bool = false
    var offset: Int = 0
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func loadData(offset: Int, completion: @escaping (NetworkError?) -> Void) {
        
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            let result = await networkService.fetchData(offset: offset)
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.items = items
                    self.offset += items.count
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error)
                    self.isLoading = false
                }
            }
        }
    }
    
    
    func loadMoreDataIfNeeded(currentItem item: Item?, completion: @escaping (NetworkError?) -> Void) {
        
        guard !isLoading else { return }
        guard let item = item else { return }
        
        let isLastItem = items.lastIndex(where: { $0.company.companyId == item.company.companyId }) == items.count.advanced(by: -1)
        
        if isLastItem {
            Task {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = true
                }
                let result = await networkService.fetchData(offset: offset)
                switch result {
                case .success(let items):
                    DispatchQueue.main.async {
                        self.items.append(contentsOf: items)
                        self.offset += items.count
                        self.isLoading = false
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(error)
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
