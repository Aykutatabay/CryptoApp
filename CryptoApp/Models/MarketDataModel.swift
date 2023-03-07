//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 3.12.2022.
//

import Foundation


// JSON Data
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response
 {
    "data":{
       "active_cryptocurrencies":13107,
       "upcoming_icos":0,
       "ongoing_icos":49,
       "ended_icos":3376,
       "markets":610,
       "total_market_cap":{
          "btc":52553189.769987054,
          "eth":701252556.6962196,
          "ltc":11600606519.200811,
          "bch":7986529310.465829,
          "bnb":3059813434.099369,
          "eos":950749909540.4763,
          "xrp":2253967476122.672,
          "xlm":10168579473470.766,
          "link":119633450926.37776,
          "dot":159291956005.4835,
          "yfi":132305363.17375454,
          "usd":890941668140.256,
          "aed":3272428747079.1665,
          "ars":149770234521882.25,
          "aud":1310787237951.3372,
          "bdt":91277392643553.53,
          "bhd":335999940364.0673,
          "bmd":890941668140.256,
          "brl":4650180051749.593,
          "cad":1202107500446.5813,
          "chf":834439929430.1396,
          "clp":787146963801918.6,
          "cny":6258597936184.858,
          "czk":20595720354064.703,
          "dkk":6285326186229.064,
          "eur":845496515531.7587,
          "gbp":724342703731.3757,
          "hkd":6940658330229.615,
          "huf":346522852406471.56,
          "idr":1.3699386371825034e+16,
          "ils":3034591868769.122,
          "inr":72556063881055.55,
          "jpy":119666830156258.4,
          "krw":1156754294800121.5,
          "kwd":273154696976.7897,
          "lkr":328313746500645.9,
          "mmk":1870987086954066.5,
          "mxn":17276694466800.107,
          "myr":3909006568965.3765,
          "ngn":395134249552157.0,
          "nok":8700045389389.629,
          "nzd":1389382548147.997,
          "php":49647723566174.19,
          "pkr":199861353028039.88,
          "pln":3952974540288.0986,
          "rub":55683845349349.445,
          "sar":3349092495739.2964,
          "sek":9205681514309.271,
          "sgd":1204820417826.0696,
          "thb":30935016446198.93,
          "try":16600916993399.078,
          "twd":27220851692522.48,
          "uah":32737784346122.285,
          "vef":89209989230.88417,
          "vnd":2.1839207640288052e+16,
          "zar":15641189282828.404,
          "xdr":674537282598.9994,
          "xag":38535605961.320076,
          "xau":495532846.4029298,
          "bits":52553189769987.055,
          "sats":5.255318976998705e+15
       },
       "total_volume":{
          "btc":2491678.994825613,
          "eth":33248148.651589602,
          "ltc":550013951.9150039,
          "bch":378661455.40439755,
          "bnb":145073455.9633658,
          "eos":45077446094.19054,
          "xrp":106866270912.49055,
          "xlm":482117945497.797,
          "link":5672123006.356379,
          "dot":7552432546.163346,
          "yfi":6272930.259146469,
          "usd":42241786841.79069,
          "aed":155154083069.8975,
          "ars":7100983766001.609,
          "aud":62147721989.5426,
          "bdt":4327690915581.2847,
          "bhd":15930602829.857716,
          "bmd":42241786841.79069,
          "brl":220476740000.25586,
          "cad":56994942105.22031,
          "chf":39562897203.858116,
          "clp":37320618674722.19,
          "cny":296735880027.52716,
          "czk":976494938064.3086,
          "dkk":298003133632.78076,
          "eur":40087117778.56467,
          "gbp":34342910636.670685,
          "hkd":329074079944.2592,
          "huf":16429520574246.088,
          "idr":649522387015426.9,
          "ils":143877638072.48132,
          "inr":3440065600411.908,
          "jpy":5673705599655.113,
          "krw":54844632478880.03,
          "kwd":12950951669.611471,
          "lkr":15566181033893.158,
          "mmk":88708206762661.72,
          "mxn":819131567300.7974,
          "myr":185335839768.3568,
          "ngn":18734309259902.684,
          "nok":412491048510.08746,
          "nzd":65874123457.577965,
          "php":2353923529517.0034,
          "pkr":9475929765576.17,
          "pln":187420471948.99918,
          "rub":2640111255194.0557,
          "sar":158788904344.05975,
          "sek":436464529796.40906,
          "sgd":57123568346.15362,
          "thb":1466706988118.9011,
          "try":787091256464.8737,
          "twd":1290609089198.549,
          "uah":1552180751527.8394,
          "vef":4229670116.468518,
          "vnd":1035451799959395.5,
          "zar":741588150228.1765,
          "xdr":31981510268.64091,
          "xag":1827070066.4783182,
          "xau":23494459.4235356,
          "bits":2491678994825.6133,
          "sats":249167899482561.3
       },
       "market_cap_percentage":{
          "btc":36.57860869027842,
          "eth":17.18660241326619,
          "usdt":7.343595020819335,
          "bnb":5.336174364367534,
          "usdc":4.850022920776996,
          "busd":2.4862161851900173,
          "xrp":2.2287854801000715,
          "doge":1.5344894639819477,
          "ada":1.2699213343829239,
          "matic":0.9200331925179328
       },
       "market_cap_change_percentage_24h_usd":-0.37750245740687305,
       "updated_at":1670071245
    }
 }
 */

struct GlobalData: Codable {
    
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        
    }
    
    // key value oldugu için hangisinin keyini girersem o verileri alırım
    
    
    // burada totalMarketCap in içinedik "btc" keyine karsılık gelen degeri marketCap degiskenine atadık
    var marketCap: String {
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    
    // burada totalVolume in içinedik "usd" keyine karsılık gelen degeri volume degiskenine atadık
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    
    // burada marketCapPercentage in içinedik "btc" keyine karsılık gelen degeri btcDominance degiskenine atadık
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}
