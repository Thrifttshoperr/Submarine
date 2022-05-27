import UIKit

class ScoreViewController: UIViewController {
    
    //MARK: - Vars, lets
    
    var resultOfTheGame = Manager.shared.loadResult()
    
    var deletedResult: Settings?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var resultTable: UITableView!
    
    @IBOutlet weak var clearButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clearButtonTitle = "Clear".localized
        clearButton.setTitle(clearButtonTitle, for: .normal)
        
        resultTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultTable.reloadData()
    }
    
    //MARK: - IBActions
    
    @IBAction func pressShowMainVC(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func pressClearResult(_ sender: UIButton) {
        
        if resultOfTheGame.count >= 1 {
            deletedResult = resultOfTheGame.removeLast()
            UserDefaults.standard.removeObject(forKey: "result")
        } else if resultOfTheGame.count == 0 {
            print("It was the last result")
            sender.isEnabled = false
        }
        
        resultTable.reloadData()
        print(resultOfTheGame.count)
        
    }
    
    @IBAction func pressReloadTable(_ sender: UIButton) {
        resultTable.reloadData()
    }
    
    //MARK: - Flow funcs
    
}

extension ScoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultOfTheGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: resultOfTheGame[indexPath.row])
        
        resultOfTheGame.sort(by: {$1.date < $0.date})
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

