import UIKit
import CoreMotion

class SecondViewController: UIViewController {
    
    
    //MARK: - Vars, lets
    
    let scoreLabelTitle = "Score is".localized
    let downButtonTitle = "Down".localized
    let upButtonTitle = "Up".localized
    
    let submarine = UIImageView(image: UIImage(named: "Submarine"))
    let ship = UIImageView(image: UIImage(named: "Ship"))
    let fish = UIImageView(image: UIImage(named: "Fish"))
    let wildFish = UIImageView(image: UIImage(named: "Fish"))
    let bitCoin = UIImageView(image: UIImage(named: "Coin"))
    
    
    let fishHeight: CGFloat = 50
    let fishWidth: CGFloat = 50
    
    let coinHeight: CGFloat = 30
    let coinWidth: CGFloat = 30
    
    var score = 0
    
    var timerBitcoin = Timer()
    var timerFish = Timer()
    var timerWildFish = Timer()
    var timerShip = Timer()
    
    let date = Date()
    let dateFormatter = DateFormatter()
    
    var managerMotion = CMMotionManager()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var seaBottom: UIImageView!
    
    @IBOutlet weak var upButton: UIButton!
    
    @IBOutlet weak var downButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObjectsToView()
        
        submarine.frame = CGRect(x: 150, y: 150, width: 110, height: 90)
        submarine.contentMode = .scaleAspectFit
        view.addSubview(submarine)
        
        upButton.setTitle(upButtonTitle, for: .normal)
        
        downButton.setTitle(downButtonTitle, for: .normal)
        
        scoreLabel.text = "\(scoreLabelTitle) \(String(self.score))"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAcceleroemeter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        moveShip()
        shipIntersects()
        
        moveFish()
        fishIntersects()
        
        moveBitcoin()
        bitCoinIntersects()
        
        moveWildFish()
        wildFishIntersects()
        
        upButton.roundCorners(radius: 25)
        upButton.dropShadow()
        downButton.roundCorners(radius: 25)
        downButton.dropShadow()
        
        sendName()
        
        checkSubmarineIcon()
        checkFishIcon()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func pressShowFirstVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        invalidateTimers()
    }
    
    @IBAction func pressUpSubmarine(_ sender: UIButton) {
        moveUpSubmarine()
    }
    
    @IBAction func pressDownSubmarine(_ sender: UIButton) {
        moveDownSubmarine()
    }
    
    //MARK: - Flow funcs
    
    func addObjectsToView() {
        view.addSubview(ship)
        view.addSubview(fish)
        view.addSubview(bitCoin)
        view.addSubview(wildFish)
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        let offsetSubmarine: CGFloat = 150
        if motion == .motionShake {
            UIView.animate(withDuration: 1) {
                self.submarine.frame.origin.y -= offsetSubmarine
            }
        }
    }
    
    func moveUpSubmarine() {
        let offsetSubmarine: CGFloat = 15
        UIView.animate(withDuration: 0.5) {
            self.submarine.frame.origin.y -= offsetSubmarine
        }
        if self.submarine.frame.origin.y < 0.0 {
            self.submarine.frame.origin.y += offsetSubmarine
        }
    }
    
    func moveDownSubmarine() {
        let offsetSubmarine: CGFloat = 15
        UIView.animate(withDuration: 0.5) {
            self.submarine.frame.origin.y += offsetSubmarine
        }
        if self.submarine.frame.origin.y > self.view.frame.maxY - 50 {
            self.submarine.frame.origin.y -= offsetSubmarine
        }
    }
    
    func addAcceleroemeter() {
        if managerMotion.isAccelerometerAvailable {
            managerMotion.accelerometerUpdateInterval = 0.1
            managerMotion.startAccelerometerUpdates(to: .main) { [weak self] data, error in
                if let acceleration = data?.acceleration {
                    if acceleration.z >= -0.9 && acceleration.z <= -0.8 {
                        self?.moveUpSubmarine()
                    }
                    if acceleration.z >= -0.7 && acceleration.z <= -0.2 {
                        self?.moveDownSubmarine()
                    }
                    
                    debugPrint("x: \(acceleration.x)")
                    debugPrint("y: \(acceleration.y)")
                    debugPrint("z: \(acceleration.z)")
                    debugPrint("")
                }
            }
        }
    }
    
    
    func checkSubmarineIcon() {
        guard let submarineIcon = UserDefaults.standard.value(forKey: "submarine") as? String else {return}
        let saveImage = Manager.shared.loadImage(fileName: submarineIcon)
        submarine.image = saveImage
    }
    
    func checkFishIcon() {
        guard let fishIcon = UserDefaults.standard.value(forKey: "fish") as? String else {return}
        let saveImage = Manager.shared.loadImage(fileName: fishIcon)
        fish.image = saveImage
        wildFish.image = saveImage
    }
    
    func gameOver() {
        
        invalidateTimers()
        
        guard let playerName = playerNameLabel.text,
              let result = scoreLabel.text
        else  {return}
        
        dateFormatter.dateFormat = "dd-MM-yyyy, HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        let gameResult = Settings(playerName: playerName, result: result, date: stringDate)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Manager.shared.addResult(gameResult)
        }
    }
    
    func invalidateTimers() {
        timerFish.invalidate()
        timerShip.invalidate()
        timerWildFish.invalidate()
        timerBitcoin.invalidate()
    }
    
    func sendName() {
        
        let name = UserDefaults.standard.string(forKey: "name")
        playerNameLabel.text = name
    }
    
    func moveBitcoin() {
        timerBitcoin = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.bitCoin.frame = CGRect(x: self.view.frame.maxX + self.bitCoin.frame.width, y: .random(in: (self.view.frame.minY + self.coinHeight)...(self.view.frame.maxY - self.coinHeight)) ,width: self.coinWidth, height: self.coinHeight)
            UIView.animate(withDuration: 5, delay: 0, options: .curveLinear) {
                self.bitCoin.frame.origin.x = self.view.frame.minX - self.bitCoin.frame.width
            }
        }
        timerBitcoin.fire()
    }
    
    func bitCoinIntersects() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if let bitCoinPresentation = self.bitCoin.layer.presentation(),
               let submarinePresentation = self.submarine.layer.presentation() {
                if bitCoinPresentation.frame.intersects(submarinePresentation.frame){
                    
                    self.timerBitcoin.invalidate()
                    self.moveBitcoin()
                    
                    self.score += 1
                    self.scoreLabel.text = "\(self.scoreLabelTitle) \(String(self.score))"
                    
                }
            }
        }
        timer.fire()
    }
    
    func moveShip() {
        
        timerShip = Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { timer in
            self.ship.frame = CGRect(x: 914, y: 15, width: 80, height: 80)
            UIView.animate(withDuration: 7, delay: 0, options: .curveLinear) {
                self.ship.frame.origin.x = self.view.frame.minX - self.ship.frame.width
            }
        }
        timerShip.fire()
    }
    
    func shipIntersects() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if let shipPresentation = self.ship.layer.presentation(),
               let submarinePresentation = self.submarine.layer.presentation() {
                if shipPresentation.frame.intersects(submarinePresentation.frame){
                    
                    self.submarine.removeFromSuperview()
                    self.ship.removeFromSuperview()
                    
                    self.gameOver()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        timer.fire()
    }
    
    func moveFish() {
        
        timerFish = Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { timer in
            self.fish.frame = CGRect(x: self.view.frame.maxX + self.fish.frame.width, y: .random(in: (self.view.frame.minY + self.fishHeight)...(self.view.frame.maxY - self.fishHeight)) ,width: self.fishWidth, height: self.fishHeight)
            UIView.animate(withDuration: 7, delay: 0, options: .curveLinear) {
                self.fish.frame.origin.x = self.view.frame.minX - self.fish.frame.width
            }
        }
        timerFish.fire()
    }
    
    func fishIntersects() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if let fishPresentation = self.fish.layer.presentation(),
               let submarinePresentation = self.submarine.layer.presentation() {
                if fishPresentation.frame.intersects(submarinePresentation.frame){
                    
                    self.fish.removeFromSuperview()
                    self.submarine.removeFromSuperview()
                    
                    self.gameOver()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        timer.fire()
        
    }
    
    func moveWildFish() {
        timerWildFish = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.wildFish.frame = CGRect(x: self.view.frame.maxX + self.wildFish.frame.width, y: .random(in: (self.view.frame.minY + self.fishHeight)...(self.view.frame.maxY - self.fishHeight)) ,width: self.fishWidth, height: self.fishHeight)
            UIView.animate(withDuration: 5, delay: 0, options: .curveLinear) {
                self.wildFish.frame.origin.x = self.view.frame.minX - self.wildFish.frame.width
            }
        }
        timerWildFish.fire()
    }
    
    func wildFishIntersects() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if let wildFishPresentation = self.wildFish.layer.presentation(),
               let submarinePresentation = self.submarine.layer.presentation() {
                if wildFishPresentation.frame.intersects(submarinePresentation.frame){
                    
                    self.wildFish.removeFromSuperview()
                    self.submarine.removeFromSuperview()
                    
                    self.gameOver()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        timer.fire()
        
    }
    
}

