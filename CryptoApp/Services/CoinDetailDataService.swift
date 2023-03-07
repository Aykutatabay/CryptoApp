//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 9.12.2022.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    
    //var cancellables = Set<AnyCancellable>()
    
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        // bir kere get edicek ve biticek ondan tek seferlik cancel(anycancellable) yaptık. Sürekli listen edilmeye ihtiyacı yok daha so
        // so when we call this (dataTaskpublisher(for: url)) basically just assumes that this url could potentially be sending us over time so when we go to call this its assumming that it might publish values now and and then it stays listening in case we have more published values in the future  but we know this url is just a simple get request so its going to go to the internet come back once its not going to come back like 5 or 10 times over the course of a minute or something like that. So if this come back one time down here (  self.coinSubscription?.cancel() ) just cancel it after that
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        // this decode is specific to this function because this url is returning us coin model
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                guard let self = self else { return }
                self.coinDetails = returnedCoinDetails
                self.coinDetailSubscription?.cancel()
            })
    }
}
