//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 28.11.2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .rank
    
    private let portfolioDataService = PortfolioDataService()
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    
    init() {
        addSubscribers()
        }

    
    func addSubscribers() {
        
        // we dont need anymore
       /* dataService.$allCoins
            .sink { [ weak self ](coinsArray) in
                guard let self = self else { return }
                self.allCoins = coinsArray
            }
            .store(in: &cancellables) */        
        
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [ weak self ] returnedArray in
                guard let self = self else { return }
                self.allCoins = returnedArray
            }
            .store(in: &cancellables)
        
        
        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mappAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
                
            }
            .store(in: &cancellables)
        
        
        
        
        // updates marketData
        marketDataService
            .$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStatisticData in
                guard let self = self else { return }
                self.statistics = returnedStatisticData
                self.isLoading = false
            }
            .store(in: &cancellables)
        // finally this subscriber we need to store it in our cancellable
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarkedData()
        HapticManager.notification(type: .success)
        
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    
    // inout: basically means we are going to take this array of coin model and we want to return out the same array of coin model ( we dont need to return keyword
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank})
        case.rankReversed, .holdingsReversed:
             coins.sort(by: { $0.rank > $1.rank})
        case .price:
             coins.sort(by: { $0.currentPrice < $1.currentPrice})
        case .priceReversed:
             coins.sort(by: { $0.currentPrice < $1.currentPrice})
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        
        
        // for each coin we want to return double
        let portfolioValue = portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = coin.priceChangePercentage24H
            let previousValue = currentValue / (1 + (percentChange ?? 0.0) )
            return previousValue
            // 25% -> 25 -> 0.25
        }
            .reduce(0, +)
        let percentChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentChange)
        
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
        
    }
    
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // will only sort by holings or reversedHoldings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func mappAllCoinsToPortfolioCoins(coinModels: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        coinModels
            .compactMap { coin -> CoinModel? in // return non-nil results
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
}
