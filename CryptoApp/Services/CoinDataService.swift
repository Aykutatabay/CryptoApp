//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 29.11.2022.
//

import Foundation
import Combine


class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    
    //var cancellables = Set<AnyCancellable>()
    
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        // bir kere get edicek ve biticek ondan tek seferlik cancel(anycancellable) yaptık. Sürekli listen edilmeye ihtiyacı yok daha so
        // so when we call this (dataTaskpublisher(for: url)) basically just assumes that this url could potentially be sending us over time so when we go to call this its assumming that it might publish values now and and then it stays listening in case we have more published values in the future  but we know this url is just a simple get request so its going to go to the internet come back once its not going to come back like 5 or 10 times over the course of a minute or something like that. So if this come back one time down here (  self.coinSubscription?.cancel() ) just cancel it after that 
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        // this decode is specific to this function because this url is returning us coin model
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.allCoins = returnedCoins
                self.coinSubscription?.cancel()
            })
    }
}
