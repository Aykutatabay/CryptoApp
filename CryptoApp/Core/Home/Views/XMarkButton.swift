//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 5.12.2022.
//

import SwiftUI

struct XMarkButton: View {
    @Binding var dismiss: Bool
    
    var body: some View {
        Button {
            dismiss = true
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }

    }
}
