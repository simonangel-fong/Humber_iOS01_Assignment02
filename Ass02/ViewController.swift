//
//  ViewController.swift
//  Ass02
//
//  Created by Simon Fong on 19/10/2023.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// A reference of a ticket model object.
    var ticketModel = (UIApplication.shared.delegate as! AppDelegate).ticketModelDelegate
    
    /// The index of tickets to display. Default as 0, the first ticket to be displayed.
    var displayTicketIndex: Int = 0
    
    @IBOutlet weak var ticketPicker: UIPickerView!
    
    @IBOutlet weak var levelDisplay: UILabel!
    
    @IBOutlet weak var quantityDisplay: UILabel!
    
    @IBOutlet weak var totalCostDisplay: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        /// By default, displays the first ticket info.
        levelDisplay.text = ticketModel.ticketList[displayTicketIndex].name
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        ticketPicker.reloadAllComponents()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ticketModel.ticketList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return "\(ticketModel.ticketList[row].name) \(ticketModel.ticketList[row].quantity) $\(ticketModel.ticketList[row].price)"
        
    }
    
    /// A function to define the action when a row is selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        levelDisplay.text = ticketModel.ticketList[row].name
        self.displayTicketIndex = row
        
        let quantity = Int(quantityDisplay.text!)!
        totalCostDisplay.text = ticketModel.getCost(index: row, number: quantity)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func inputQuan(_ sender: UIButton) {
        
        if let input = sender.titleLabel?.text {
            if quantityDisplay.text! == "0" {
                quantityDisplay.text! = input
            } else{
                quantityDisplay.text! += input
            }
        }
    }
    
    @IBAction func buy(_ sender: UIButton) {
               
        let result = ticketModel.purchase(
            index: displayTicketIndex,
            number: Int(quantityDisplay.text!)!
        )
        if let infoMsg = result.sucessInfo {
            showAlert(title:"Success", msg:infoMsg)
            reset()
        }else{
            showAlert(title:"Error", msg:result.errorInfo!)
        }
        
    }
    
    
    func showAlert(title:String,msg:String) {
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionOk)
        present(alert, animated: true)
        
    }
    
    
    func reset(){
        totalCostDisplay.text = "$ 0.00"
        quantityDisplay.text = "0"
        ticketPicker.reloadAllComponents()
    }
}
