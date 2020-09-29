//
//  ManageData.swift
//  ChallengeDay77
//
//  Created by Xiaolong Zhang on 9/28/20.
//

import Foundation
import UIKit

class ManageData {
    // Method to get document directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }

    // Loading locations using CodableMKPointAnnotation
    func loadPeople() -> [Person] {
        let filename = getDocumentsDirectory().appendingPathComponent("SavePhotos")
        
        do {
            let data = try Data(contentsOf: filename)
            let people = try JSONDecoder().decode([Person].self, from: data)
            return people
        } catch {
            print("Unable to load saved data")
        }
        return []
    }
    
    // Save data with atomicWrite and completeFileProtection options to make sure data is storied atomically and has file protection
    func save(_ people: [Person]) {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavePhotos")
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    func saveImage(pathName: String, uiImage: UIImage) {
        let fileName = getDocumentsDirectory().appendingPathComponent(pathName)
        do {
            if let jpegData = uiImage.jpegData(compressionQuality: 0.5) {
                try jpegData.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
            }
        } catch {
            print("Unable to save image")
        }
    }
    
    func loadImageData(pathName: String) -> Data? {
        let fileName = getDocumentsDirectory().appendingPathComponent(pathName)
        do {
            let data = try Data(contentsOf: fileName)
            return data
        } catch {
            print("Unable to load data")
        }
        return nil
    }
    
    func loadImage(pathName: String) -> UIImage? {
        if let data = loadImageData(pathName: pathName) {
            return UIImage(data: data)
        }
        return nil
    }
}
