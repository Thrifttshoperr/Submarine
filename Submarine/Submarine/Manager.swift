import Foundation
import UIKit

class Manager {
    
    static let shared = Manager()
    private init() {}

    func addResult(_ result: Settings) {
        var results = self.loadResult()
        results.append(result)
        UserDefaults.standard.set(encodable: results, forKey: "result")
    }

    func loadResult() -> [Settings] {
        guard let results = UserDefaults.standard.value([Settings].self, forKey: "result") else {
            return []
        }
        return results
    }
    
    func saveImage(_ image: UIImage) -> String? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = UUID().uuidString
        
        guard let fileURL = documentsDirectory?.appendingPathComponent(fileName),
              let imageData = image.pngData() else { return nil}
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        }
        do {
            try imageData.write(to: fileURL)
            return fileName
        } catch let error {
            print(error.localizedDescription)
            return nil
        }

    }
    
    func loadImage(fileName: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        let image = UIImage(contentsOfFile: fileURL.path)
        
        return image
    }

}
