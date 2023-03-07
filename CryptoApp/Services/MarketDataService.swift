//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 3.12.2022.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    
    //var cancellables = Set<AnyCancellable>()
    
    var marketDataSubscripiton: AnyCancellable?
    
    init() {
        getMarkedData()
    }
    
    func getMarkedData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        marketDataSubscripiton = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                guard let self = self else { return }
                self.marketData = returnedGlobalData.data
                self.marketDataSubscripiton?.cancel()
            })
        
        
    }
}
