import Foundation
import UIKit

extension UIButton {
    
    func roundCorners(radius: CGFloat) {
        
        self.layer.cornerRadius = radius
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.orange.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 20
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}

extension String {
    
    var localized: String {
        
        return NSLocalizedString(self, comment: "")
        
    }    
}

extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String) { // Т - любой тип данных (String, Person, Beer etc)
        guard let data = try? JSONEncoder().encode(encodable) else { return } // превращаем входящий объект Codable в 010101101101
        set(data, forKey: key)  // записываем 01010101010 в UserDefaults
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? { // Т - любой тип данных (String, Person, Beer etc), T.Type - имя класса для этого типа
        guard let data = object(forKey: key) as? Data, // читаем 001010001 из UserDefaults
              let value = try? JSONDecoder().decode(type, from: data) else { return nil } // пытаемся конвертировать 0010101 в нужный нам объект класса Т
        return value // возвращаем объект
    }
    
}

