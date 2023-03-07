//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 1.12.2022.
//

import Foundation
import SwiftUI


class LocalFileManager {
    
    static let instance = LocalFileManager() // singleton
    
    
    
    private init() { }
    
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // crete folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
            else { return }
        
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image, image name: \(imageName). \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            // this file isnt exist, runs here
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory folder name \(folderName). \(error.localizedDescription)")
            }
        }
    }
    
    
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        // cachesDirectory hafıza dolunca ilk eklediklerini siler. tekrar indirir ihtiyac halinde
        
        return url.appendingPathComponent(folderName)
        // return us the folder url that we are looking for
    }
    
    
    
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
        
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
    
}
