import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - Vars, lets
    
    var arrayOfResult = Manager.shared.loadResult()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var playerName: UITextField!
    
    @IBOutlet weak var chooseSubmarineImageView: UIImageView!
    
    @IBOutlet weak var chooseObstacleImageView: UIImageView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var fishSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var changeNameButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapDetected(_:)))
        self.view.addGestureRecognizer(recognizer)
        
        let changeNameButtonTitle = "Change name".localized
        changeNameButton.setTitle(changeNameButtonTitle, for: .normal)
        
        let segmentedCartoonSubmarineTitle = "Cartoon".localized
        segmentedControl.setTitle(segmentedCartoonSubmarineTitle, forSegmentAt: 0)
        let segmentedMilitarySubmarineTitle = "Military".localized
        segmentedControl.setTitle(segmentedMilitarySubmarineTitle, forSegmentAt: 1)
        
        let segmentedCartoonFishTitle = "Cartoon".localized
        fishSegmentedControl.setTitle(segmentedCartoonFishTitle, forSegmentAt: 0)
        let segmentedWildFishTitle = "Wild".localized
        fishSegmentedControl.setTitle(segmentedWildFishTitle, forSegmentAt: 1)
        
        let playerNamePlaceholderTitle = "Enter the text".localized
        playerName.placeholder = playerNamePlaceholderTitle
        
        loadInfoByDefault()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadInfoByDefault()
    }
    
    //MARK: - IBActions
    
    @IBAction func showMainVC(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tapDetected(_ recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func pressChangePlayerName(_ sender: UIButton) {
        
        let name = playerName.text
        UserDefaults.standard.set(name, forKey: "name")
    }
    
    @IBAction func changeSubmarine(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // saveimage
            guard let image = UIImage(named: "Submarine") else {return}
            let imageName = Manager.shared.saveImage(image)
            UserDefaults.standard.set(imageName, forKey: "submarine")
            
            // loadimage
            guard let submarineIcon = UserDefaults.standard.value(forKey: "submarine") as? String else {return}
            let saveImage = Manager.shared.loadImage(fileName: submarineIcon)
            chooseSubmarineImageView.image = saveImage
            
        case 1:
            // saveimage
            guard let image = UIImage(named: "Army submarine") else {return}
            let imageName = Manager.shared.saveImage(image)
            UserDefaults.standard.set(imageName, forKey: "submarine")
            
            // loadimage
            guard let submarineIcon = UserDefaults.standard.value(forKey: "submarine") as? String else {return}
            let saveImage = Manager.shared.loadImage(fileName: submarineIcon)
            chooseSubmarineImageView.image = saveImage
            
        default:
            self.chooseSubmarineImageView.image = UIImage(named: "Submarine")
            print("No submarine icons have chosen")
        }
        
    }
    
    @IBAction func changeFish(_ sender: UISegmentedControl) {
        switch fishSegmentedControl.selectedSegmentIndex {
        case 0:
            // saveimage
            guard let image = UIImage(named: "Fish") else {return}
            let imageName = Manager.shared.saveImage(image)
            UserDefaults.standard.set(imageName, forKey: "fish")
            
            // loadimage
            guard let fishIcon = UserDefaults.standard.value(forKey: "fish") as? String else {return}
            let saveImage = Manager.shared.loadImage(fileName: fishIcon)
            chooseObstacleImageView.image = saveImage
            
            UserDefaults.standard.value(forKey: "segment")
            
        case 1:
            //saveimage
            guard let image = UIImage(named: "Wild fish") else {return}
            let imageName = Manager.shared.saveImage(image)
            UserDefaults.standard.set(imageName, forKey: "fish")
            
            // loadimage
            guard let fishIcon = UserDefaults.standard.value(forKey: "fish") as? String else {return}
            let saveImage = Manager.shared.loadImage(fileName: fishIcon)
            chooseObstacleImageView.image = saveImage
            
            UserDefaults.standard.value(forKey: "segment")
            
        default:
            print("No fish icons have chosen")
            
        }
    }
    
    //  MARK: - Flow funcs
    
    func loadInfoByDefault() {
        
        if arrayOfResult.isEmpty {
            chooseSubmarineImageView.image = UIImage(named: "Submarine")
            chooseObstacleImageView.image = UIImage(named: "Fish")
        }
        
        guard let submarineIcon = UserDefaults.standard.value(forKey: "submarine") as? String else {return}
        let saveImageSubmarine = Manager.shared.loadImage(fileName: submarineIcon)
        chooseSubmarineImageView.image = saveImageSubmarine
        
        guard let fishIcon = UserDefaults.standard.value(forKey: "fish") as? String else {return}
        let saveImageFish = Manager.shared.loadImage(fileName: fishIcon)
        chooseObstacleImageView.image = saveImageFish
        
    }
    
}







