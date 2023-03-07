//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 1.12.2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil

    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved image from file File Manager !")
        } else {
            downloadCoinImage()
            print("Donloading image now !")
        }
        
    }
    
    
    private func downloadCoinImage() {

        
        guard let url = URL(string: coin.image) else { return }
        
        // bir kere get edicek ve biticek ondan tek seferlik cancel(anycancellable) yaptık. Sürekli listen edilmeye ihtiyacı yok daha so
        // so when we call this (dataTaskpublisher(for: url)) basically just assumes that this url could potentially be sending us over time so when we go to call this its assumming that it might publish values now and and then it stays listening in case we have more published values in the future  but we know this url is just a simple get request so its going to go to the internet come back once its not going to come back like 5 or 10 times over the course of a minute or something like that. So if this come back one time down here (  self.coinSubscription?.cancel() ) just cancel it after that
        
        NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (returnedImage) in
                    guard let self = self, let downloadingImage = returnedImage else { return }
                    self.image = downloadingImage
                    self.fileManager.saveImage(image: downloadingImage, imageName: self.imageName, folderName: self.folderName)
                })
            .store(in: &subscriptions)
    }
}
