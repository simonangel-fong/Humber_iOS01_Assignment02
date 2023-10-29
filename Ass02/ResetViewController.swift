//
//  ResetViewController.swift
//  Ass02
//
//  Created by Simon Fong on 20/10/2023.
//

import UIKit

/// This the view controller of the detail.
class ResetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// A reference of a ticket model object.
    var ticketModel = (UIApplication.shared.delegate as! AppDelegate).ticketModelDelegate
    
    /// The row of the ticket. Default value is 0, the first.
    var rowNum:Int = 0
    
    /// IBOutlet connections
    @IBOutlet weak var levelDisplay: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var txtBox: UITextField!
    
    /// Override the viewDidLoad() function to setup Outlet items to display.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets text to display.
        levelDisplay.text = ticketModel.ticketList[rowNum].name
    }
    
    /// Function to define the number of components in the picker view.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// Function to define the number of rows in the picker view.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ticketModel.ticketList.count
    }
    
    /// Function to define the title for each row.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return "\(ticketModel.ticketList[row].name) \(ticketModel.ticketList[row].quantity) $\(ticketModel.ticketList[row].price)"
    }
    
    
    /// Function to define the action when a row is selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        /// update the rowNum value
        self.rowNum = row
        
        /// sets the text of label.
        levelDisplay.text = ticketModel.ticketList[row].name
    }
    
    /// IBAction to update ticket's quantity.
    @IBAction func update(_ sender: UIButton) {
        if let quan = txtBox.text{
            if !quan.isEmpty{
                // Calls update() function of the model
                let result = ticketModel.updateTicket(index: self.rowNum, newQuantity: Int(txtBox.text!)!)
                
                // show alert.
                showAlert(title:"Success", msg:result)
                
                // reset outlet items
                reset()
                
                // reload picker view's data
                pickerView.reloadAllComponents()
            }
        }
    }
    
    /// IBAction to cancel.
    @IBAction func cancel(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        
        // Calls resetTicket() of the model
        let result  = ticketModel.resetTicket()
        
        // show alert.
        showAlert(title:"Success", msg:result)
        
        // reset outlet items
        reset()
        
        // reload picker view's data
        pickerView.reloadAllComponents()
    }
    
    
    /// Function to show alert.
    func showAlert(title:String,msg:String) {
        // Creates alert controller object.
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        
        // Creates alert action object.
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        
        // Binds alert action with alert controller.
        alert.addAction(actionOk)
        
        // presents alert.
        present(alert, animated: true)
        
    }
    
    /// Function to reset text.
    func reset(){
        txtBox.text = ""
    }
}
