//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 2.12.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
