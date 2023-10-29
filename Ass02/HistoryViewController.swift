//
//  HistoryViewController.swift
//  Ass02
//
//  Created by Simon Fong on 28/10/2023.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ticketModel = (UIApplication.shared.delegate as! AppDelegate).ticketModelDelegate
    
    
    @IBOutlet weak var tbView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ticketModel.recordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell!.textLabel?.text = "\(ticketModel.recordList[indexPath.row].name)"
        cell!.detailTextLabel?.text = "\(ticketModel.recordList[indexPath.row].quantity)"
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let indexPath = tbView.indexPathForSelectedRow {
                
                let controller = segue.destination as! DetailViewController
                controller.recordIndex = indexPath.row
            }
        }
    }
}

