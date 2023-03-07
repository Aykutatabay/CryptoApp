//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 5.12.2022.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var selectedCoin: CoinModel?
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    @State private var isDismissed: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment:.leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem( placement: .navigationBarLeading) {
                    XMarkButton(dismiss: $isDismissed)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
        .onChange(of: isDismissed) { dismissed in
            if dismissed {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}


extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)                        
                        )
                        .frame(height: 120)
                        .padding(.leading)
                }
            }
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin        
        if
            let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
            let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
        
        
        
        
    }
    
    
    
    private func getCurrentValue() -> Double {
        if let quantitity = Double(quantityText) {
            return quantitity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding: ")
                Spacer()
                TextField("Ex. 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButtons: some View {
        HStack (spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0 )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText) else { return }
        
        
        // save the portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // shoo-w checkmark
        
        withAnimation {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide the keyword
        UIApplication.shared.endEditing()
        
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
        
    }
}



