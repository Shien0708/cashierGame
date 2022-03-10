//
//  ViewController.swift
//  cashierGame
//
//  Created by 方仕賢 on 2022/3/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var currentImageView: UIImageView!
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var bodyImageView: UIImageView!
    @IBOutlet weak var changeCountStepper: UIStepper!
    @IBOutlet weak var totalChangeLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    
    @IBOutlet weak var customerCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var pauseView: UIView!
    
    @IBOutlet weak var customerCountSlider: UISlider!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet var moneyButtons: [UIButton]!
    @IBOutlet var moneyLabels: [UILabel]!
    
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBOutlet weak var wrongLabel: UILabel!
    var currentMoneyIndex = 0
    var moneyCount = [Int](repeating: 0, count: 6)
    var currentChanges = [Int](repeating: 0, count: 6)
    var totalChange = 0
    var givenMoney = 0
    var price = 0
    var questionCount = 1
    var correct = 0
    var wrong = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changePerson()
    }
    
    func next() {
        questionCount -= 1
        if questionCount == 0 {
            let _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                self.resultView.isHidden = false
                self.wrongLabel.text = "\(self.wrong)"
                self.correctLabel.text = "\(self.correct)"
            }
        } else {
            let _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(update), userInfo: nil, repeats: false)
        }
        pauseView.isHidden = false
    }
    
    func changePerson(){
        let bodyIndex = Int.random(in: 0...5)
        
        faceImageView.image = UIImage(named: "face-0")
        bodyImageView.image = UIImage(named: "body-"+"\(bodyIndex)")
    }
    
    @IBAction func choose(_ sender: UIButton) {
        
        switch sender {
        case moneyButtons[0]:
            currentImageView.image = UIImage(named: "1")
            currentMoneyIndex = 0
            currentLabel.text = "X \(moneyCount[0])"
            changeCountStepper.value = Double(moneyCount[0])
        case moneyButtons[1]:
            currentImageView.image = UIImage(named: "5")
            currentMoneyIndex = 1
            currentLabel.text = "X \(moneyCount[1])"
            changeCountStepper.value = Double(moneyCount[1])
        case moneyButtons[2]:
            currentImageView.image = UIImage(named: "10")
            currentMoneyIndex = 2
            currentLabel.text = "X \(moneyCount[2])"
            changeCountStepper.value = Double(moneyCount[2])
        case moneyButtons[3]:
            currentImageView.image = UIImage(named: "50")
            currentMoneyIndex = 3
            currentLabel.text = "X \(moneyCount[3])"
            changeCountStepper.value = Double(moneyCount[3])
        case moneyButtons[4]:
            currentImageView.image = UIImage(named: "100")
            currentMoneyIndex = 4
            currentLabel.text = "X \(moneyCount[4])"
            changeCountStepper.value = Double(moneyCount[4])
        default:
            currentImageView.image = UIImage(named: "500")
            currentMoneyIndex = 5
            currentLabel.text = "X \(moneyCount[5])"
            changeCountStepper.value = Double(moneyCount[5])
        }
        
    }
    
    
    @IBAction func changeCount(_ sender: UIStepper) {
        switch currentMoneyIndex {
        case 0:
            moneyCount[0] = Int(sender.value)
            currentLabel.text = "X \(moneyCount[0])"
            moneyLabels[0].text = currentLabel.text
            currentChanges[0] = Int(moneyCount[0]) * 1
        case 1:
            moneyCount[1] = Int(sender.value)
            currentLabel.text = "X \(moneyCount[1])"
            moneyLabels[1].text = currentLabel.text
            currentChanges[1] = Int(moneyCount[1]) * 5
        case 2:
            moneyCount[2] = Int(sender.value)
            currentLabel.text = "X \(moneyCount[2])"
            moneyLabels[2].text = currentLabel.text
            currentChanges[2] = Int(moneyCount[2]) * 10
        case 3:
            moneyCount[3] = Int(sender.value)
            currentLabel.text = "X \(moneyCount[3])"
            moneyLabels[3].text = currentLabel.text
            currentChanges[3] = Int(moneyCount[3]) * 50
        case 4:
            moneyCount[4] = Int(sender.value)
            currentLabel.text = "X \(moneyCount[4])"
            moneyLabels[4].text = currentLabel.text
            currentChanges[4] = Int(moneyCount[4]) * 100
        default:
            moneyCount[5] = Int(sender.value)
            currentLabel.text = "X \(moneyCount[5])"
            moneyLabels[5].text = currentLabel.text
            currentChanges[5] = Int(moneyCount[5]) * 500
        }
        
        totalChange = 0
        for i in currentChanges {
            totalChange += i
        }
        totalChangeLabel.text = "$\(totalChange)"
        
    }
    
    
    @IBAction func giveChanges(_ sender: UIButton) {
        
        
        if totalChange + price == givenMoney {
            faceImageView.image = UIImage(named: "happyFace")
            customerLabel.text = "Thanks!"
            correct += 1
        } else {
            faceImageView.image = UIImage(named: "face-3")
            customerLabel.text = "Hey, you should give me $\(givenMoney-price)"
            wrong += 1
        }
        
        next()
        
    }
    
    @objc func update(){
        pauseView.isHidden = true
        changePerson()
        price = Int.random(in: 10...450)
        givenMoney = Int.random(in: price...500)
        customerLabel.text = "Pay $\(givenMoney)"
        itemImageView.image = UIImage(named: "item-"+"\(Int.random(in: 0...5))")
        priceLabel.text = "\(price)"
        totalChange = 0
        currentLabel.text = "X 0"
        totalChangeLabel.text = "$ 0"
        currentImageView.image = UIImage(named: "1")
        for i in 0...currentChanges.count-1 {
            currentChanges[i] = 0
            moneyCount[i] = 0
            moneyLabels[i].text = "X 0"
        }
        
    }
    
    @IBAction func start(_ sender: Any) {
        startView.isHidden = true
        questionCount = Int(customerCountSlider.value)
        update()
    }
    
    
    @IBAction func playAgain(_ sender: Any) {
        startView.isHidden = false
        resultView.isHidden = true
        correct = 0
        wrong = 0
    }
    
    
    @IBAction func changeCustomerCounts(_ sender: UISlider) {
        customerCountLabel.text = "\(Int(sender.value))"
        questionCount = Int(sender.value)
    }
    
}

