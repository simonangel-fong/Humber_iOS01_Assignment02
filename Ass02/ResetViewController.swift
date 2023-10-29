//
//  ResetViewController.swift
//  Ass02
//
//  Created by Simon Fong on 20/10/2023.
//

import UIKit

class ResetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var ticketModel = (UIApplication.shared.delegate as! AppDelegate).ticketModelDelegate
    
    var rowNum:Int = 0

    @IBOutlet weak var levelDisplay: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var txtBox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        levelDisplay.text = ticketModel.ticketList[rowNum].name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ticketModel.ticketList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return "\(ticketModel.ticketList[row].name) \(ticketModel.ticketList[row].quantity) $\(ticketModel.ticketList[row].price)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.rowNum = row
        levelDisplay.text = ticketModel.ticketList[row].name
    }
    
    @IBAction func update(_ sender: UIButton) {
        if let quan = txtBox.text{
            if !quan.isEmpty{
                let result = ticketModel.updateTicket(index: self.rowNum, newQuantity: Int(txtBox.text!)!)

                    showAlert(title:"Success", msg:result)

                reset()
                pickerView.reloadAllComponents()
                print(result)
            }
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        reset()
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
        txtBox.text = ""
    }
}
