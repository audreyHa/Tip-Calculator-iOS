//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
   @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var inputCardView: UIView!
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var tipPercentSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    
    // MARK: - View Lifecycle
    func calculate(){
        if self.billAmountTextField.isFirstResponder{
            self.billAmountTextField.resignFirstResponder()
        }
        
        guard let billAmountText = self.billAmountTextField.text,
            let billAmount=Double(billAmountText) else{
                clear()
                return
        }
        let roundedBillAmount=(billAmount*100).rounded()/100
        var tipPercent: Double
        switch tipPercentSegmentControl.selectedSegmentIndex {
        case 0:
            tipPercent = 0.15
        case 1:
            tipPercent = 0.18
        case 2:
            tipPercent = 0.20
        default:
            preconditionFailure("Unexpected index.")
        }

        let tipAmount=(roundedBillAmount*tipPercent)
        let roundedTipAmount=(tipAmount*100).rounded()/100
        let totalAmount=roundedBillAmount+roundedTipAmount
        self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount)
        self.tipAmountLabel.text = String(format: "%.2f", roundedTipAmount)
        self.totalAmountLabel.text = String(format: "%.2f", totalAmount)
    }
    
    func clear(){
        billAmountTextField.text=nil
        tipPercentSegmentControl.selectedSegmentIndex=0
        tipAmountLabel.text="$0.00"
        totalAmountLabel.text="$0.00"
        
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        self.clear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.calculateButtonAction = {
           self.calculate()
        }
    }
    @IBAction func themeToggled(_ sender: UISwitch) {
        if sender.isOn{
            print("Toggle is on")
        } else{
            print("Toggle is off")
        }
    }
    
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
        self.calculate()
    }
}

