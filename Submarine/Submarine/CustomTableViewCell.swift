import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak private var playerNameLabel: UILabel!
    
    @IBOutlet weak private var scoreLabel: UILabel!
    
    @IBOutlet weak private var dateLabel: UILabel!
    
    func configure(with result: Settings) {
        self.playerNameLabel.text = result.playerName
        self.scoreLabel.text = result.result
        self.dateLabel.text = result.date

    }

 
    
}

