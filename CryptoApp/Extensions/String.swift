//
//  String.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 10.12.2022.
//

import Foundation

extension String {
    
    var removingHTMLOccurences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
