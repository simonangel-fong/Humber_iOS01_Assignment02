//
//  HistoryViewController.swift
//  Ass02
//
//  Created by Simon Fong on 28/10/2023.
//

import UIKit

/// This the view controller of the history list.
class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// A reference of a ticket model object.
    var ticketModel = (UIApplication.shared.delegate as! AppDelegate).ticketModelDelegate
    
    /// IBOutlet connections
    @IBOutlet weak var tbView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Function to define the number of section in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Function to define the number of rows.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ticketModel.recordList.count
    }
    
    /// Function to define the cell of the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        /// Sets text of title
        cell!.textLabel?.text = "\(ticketModel.recordList[indexPath.row].name)"
        
        /// Sets the text of subtitle
        cell!.detailTextLabel?.text = "\(ticketModel.recordList[indexPath.row].quantity)"
                
        return cell!
    }
    
    /// Function to pass data to the view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// Using identifier
        if segue.identifier == "showDetail"{
            
            /// Get the selected row
            if let indexPath = tbView.indexPathForSelectedRow {
                
                /// Reference the target view controller.
                let controller = segue.destination as! DetailViewController
                
                /// pass data to the target controller.
                controller.recordIndex = indexPath.row
            }
        }
    }
}
