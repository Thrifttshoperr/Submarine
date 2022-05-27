import Foundation
import UIKit

class Settings: Codable {

    var playerName: String
    var result: String
    var date: String
   
    init(playerName: String, result: String, date: String){
        
    self.playerName = playerName
    self.result = result
    self.date = date
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case playerName
        case result
        case date
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(playerName, forKey: .playerName)
        try container.encode(result, forKey: .result)
        try container.encode(date, forKey: .date)

        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.playerName = try container.decode(String.self, forKey: .playerName)
        self.result = try container.decode(String.self, forKey: .result)
        self.date = try container.decode(String.self, forKey: .date)
    }
    
    
}

