import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var scoreButton: UIButton!
    
    @IBOutlet weak var noticeView: UIView!
    
    @IBOutlet weak var noticeLabel: UILabel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startButtonTitle = "Start".localized
        startButton.setTitle(startButtonTitle, for: .normal)
        
        let settingsButtonTitle = "Settings".localized
        settingsButton.setTitle(settingsButtonTitle, for: .normal)
        
        let scoreButtonTitle = "Score".localized
        scoreButton.setTitle(scoreButtonTitle, for: .normal)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        startButton.roundCorners(radius: 30)
        startButton.dropShadow()
        
        settingsButton.roundCorners(radius: 30)
        settingsButton.dropShadow()
        
        scoreButton.roundCorners(radius: 30)
        scoreButton.dropShadow()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func pressShowSecondVC(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func pressShowSettingsVC(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func pressShowScoreVC(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

