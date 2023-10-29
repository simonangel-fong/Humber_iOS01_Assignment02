//
//  DetailViewController.swift
//  Ass02
//
//  Created by Simon Fong on 20/10/2023.
//

import UIKit

/// This the view controller of the detail.
class DetailViewController: UIViewController {
    
    /// A reference of a ticket model object.
    var ticketModel:TicketModel = (UIApplication.shared.delegate as! AppDelegate).ticketModelDelegate
    
    /// Default record index, the first record
    var recordIndex:Int = 0
    
    /// IBOutlet connections
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var lblDateTime: UILabel!
    
    /// Override the viewDidLoad() function to get the data passed by segue and prepare to display.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Since the record index is passed, the according record can be retrieved.
        let record = ticketModel.recordList[recordIndex]
        
        /// Display record information.
        lblName.text = record.name
        lblQuantity.text = String(record.quantity)
        lblTotalAmount.text = String(format: "$ %.2f", Double(record.quantity) * record.price)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm"
        lblDateTime.text = dateFormatter.string(for: record.date)
    }
    
    /// IBAction to define dismission of the detail and go back to history.
    @IBAction func btnDismiss(_ sender: UIButton) {
        /// call dismiss function to go back
        ///     animated parameter must be false, otherwise, app stuck.
        dismiss(animated: false)
    }
    
    
    
    
}
