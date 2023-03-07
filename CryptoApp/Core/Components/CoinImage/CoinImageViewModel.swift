//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 1.12.2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    
    
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { image in
                self.image = image
            }
            .store(in: &cancellables)
    }
    
}
