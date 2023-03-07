//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 28.11.2022.
//

import Foundation

// JSON Response
/*
 {
       "id":"bitcoin",
       "symbol":"btc",
       "name":"Bitcoin",
       "image":"https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
       "current_price":16596.29,
       "market_cap":318975839571,
       "market_cap_rank":1,
       "fully_diluted_valuation":348544568224,
       "total_volume":15941325581,
       "high_24h":16597.83,
       "low_24h":16423.19,
       "price_change_24h":71.61,
       "price_change_percentage_24h":0.43335,
       "market_cap_change_24h":1421953896,
       "market_cap_change_percentage_24h":0.44778,
       "circulating_supply":19218468.0,
       "total_supply":21000000.0,
       "max_supply":21000000.0,
       "ath":69045,
       "ath_change_percentage":-75.96076,
       "ath_date":"2021-11-10T14:24:11.849Z",
       "atl":67.81,
       "atl_change_percentage":24377.33288,
       "atl_date":"2013-07-06T00:00:00.000Z",
       "roi":null,
       "last_updated":"2022-11-27T22:03:38.528Z",
       "sparkline_in_7d":{
          "price":[
             16561.594183007754,
             16588.88217544183
          ]
       },
       "price_change_percentage_24h_in_currency":0.4333533090429273
    },
 */

struct CoinModel: Identifiable, Codable {
    
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath = "ath"
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl = "atl"
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings = "current_holdings"
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0.0) * currentPrice
    }
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
