//
//  ViewController.swift
//  Ass02
//
//  Created by Simon Fong on 19/10/2023.
//

import UIKit

/// This is the view controller of the main entry.
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// A reference of a ticket model object.
    var ticketModel = (UIApplication.shared.delegate as! AppDelegate).ticketModelDelegate
    
    /// IBOutlet connections
    @IBOutlet weak var ticketPicker: UIPickerView!
    
    @IBOutlet weak var levelDisplay: UILabel!
    
    @IBOutlet weak var quantityDisplay: UILabel!
    
    @IBOutlet weak var totalCostDisplay: UILabel!
    
    /// The index of tickets to display. Default as 0, the first ticket to be displayed.
    var displayTicketIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// By default, displays the first ticket info.
        levelDisplay.text = ticketModel.ticketList[displayTicketIndex].name
    }
    
    /// override the function to be trigger in response to a change in the state of the application,
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // call superclass method
        ticketPicker.reloadAllComponents()  // reload picker view
    }
    
    /// Function to define the number of components of the picker view.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// Function to define the number of rows in the picker view.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ticketModel.ticketList.count
    }
    
    /// Function to define the title to display for each row of the picker view.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return "\(ticketModel.ticketList[row].name) \(ticketModel.ticketList[row].quantity) $\(ticketModel.ticketList[row].price)"
    }
    
    /// A function to define the action when a row is selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        // update the text of the lable
        levelDisplay.text = ticketModel.ticketList[row].name
        
        // update the current index
        self.displayTicketIndex = row
        
        // get the number of ticket to be purchased.
        let quantity = Int(quantityDisplay.text!)!
        
        // calls getCost() function of the model to display total cost.
        totalCostDisplay.text = ticketModel.getCost(index: row, number: quantity)
    }
    
    // IBAction to reset all items.
    @IBAction func reset(_ sender: UIButton) {
        reset()
    }
    
    // IBAction to get the input and display.
    @IBAction func inputQuan(_ sender: UIButton) {
        
        if let input = sender.titleLabel?.text {
            // If the current the text of the quantity is zero, then display the input
            //      Otherwise, concatenate the input .
            if quantityDisplay.text! == "0" {
                quantityDisplay.text! = input
            } else{
                quantityDisplay.text! += input
            }
        }
    }
    
    // IBAction to implement purchase
    @IBAction func buy(_ sender: UIButton) {
        
        // calls the purchase() function of the model
        let result = ticketModel.purchase(
            index: displayTicketIndex,
            number: Int(quantityDisplay.text!)!
        )
        
        // Display message accordingly, using alert.
        if let infoMsg = result.sucessInfo {
            showAlert(title:"Success", msg:infoMsg)
            // if purchase successes, reset items.
            reset()
        }else{
            showAlert(title:"Error", msg:result.errorInfo!)
        }
        
    }
    
    /// Function to define alert's display
    func showAlert(title:String,msg:String) {
        
        // Creates alert controller object.
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        
        // Creates an alert action
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        
        // bind action with alert controller.
        alert.addAction(actionOk)
        
        // present alert component with animatioin.
        present(alert, animated: true)
        
    }
    
    /// Function to reset text and reload picker view's data
    func reset(){
        totalCostDisplay.text = "$ 0.00"
        quantityDisplay.text = "0"
        ticketPicker.reloadAllComponents()
    }
}
