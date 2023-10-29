//
//  DetailViewController.swift
//  Ass02
//
//  Created by Simon Fong on 20/10/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var ticketModel:TicketModel = (UIApplication.shared.delegate as! AppDelegate).ticketModelDelegate
    
    var recordIndex:Int = 0
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var lblDateTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let record = ticketModel.recordList[recordIndex]
        
        lblName.text = record.name
        lblQuantity.text = String(record.quantity)
        lblTotalAmount.text = String(format: "$ %.2f", Double(record.quantity) * record.price)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm"
        lblDateTime.text = dateFormatter.string(for: record.date)
    }
    
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        /// call dismiss function to go back
        ///     animated parameter must be false, otherwise, app stuck.
        dismiss(animated: false)
    }
}
