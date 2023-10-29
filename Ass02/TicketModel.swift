//
//  TicketModel.swift
//  Ass02
//
//  Created by Simon Fong on 19/10/2023.
//

import Foundation

/// A class to represent ticket.
class Ticket{
    
    /// The name of this ticket.
    var name:String
    
    /// The quantity of this ticket.
    var quantity:Int
    
    /// The price of this ticket.
    var price:Double
    
    /**
     Initializes a new ticket with the provided name, quantity, and price.
     
     - Parameters:
        - name:The name of the ticket.
        - quantity: The quantity of the ticket.
        - price: The price of thi ticket.
     
     - Returns: An object of ticket.
     */
    init(name: String, quantity: Int, price: Double) {
        self.name = name
        self.quantity = quantity
        self.price = price
    }
}


/// A class to represent record, inheriting from Ticket class
class Record:Ticket{
    
    /// The date of puchased ticket.
    var date: Date
    
    /**
     Initializes a new record with the provided ticket item.
     - Parameters:
        - ticketItem: The object of purchased ticket.
     
     - Returns: An object of purchased ticket.
     */
    init(ticketName:String, purchasedNumber:Int, ticketPrice:Double) {
        self.date = Date()
        super.init(name: ticketName, quantity: purchasedNumber, price: ticketPrice)
    }
}


/// A class to represent a model of the app.
class TicketModel{
    
    /// The repo of all tickets.
    var ticketList: [Ticket]
    
    /// The history of all purchased tickets.
    var recordList: [Record]
    
    /**
     Initializes a new model of the app with provided repo of all tickets and empty purchased history.
     - Parameters:
        - initTickets: The repo of tickets for initialization.
     - Returns: An object of app model.
     */
    init() {
        self.ticketList = [
            Ticket(name: "Balcony", quantity: 12, price: 1170),
            Ticket(name: "Lower", quantity: 20, price: 10434),
            Ticket(name: "Courtside", quantity: 15, price: 27777)
        ]
        self.recordList = [Record]()
    }
    
    /**
     Purchases a ticket with a given index.
     - Parameters:
        - index: The index of a ticket.
        - number: The number of ticket to purchase.
     
     - Returns:
        - sucessInfo:  A string of success information.
        - errorInfo:  A string of success information.
     */
    func purchase(index:Int, number:Int) -> (sucessInfo:String?, errorInfo:String?) {
        
        /// The ticket object with a given index.
        let ticket = self.ticketList[index]
        
        /// Whether the purchased number is not zero.
        ///     If true, keep going.
        ///     Otherwise, return error info.
        guard(number != 0 ) else{
            return (nil,"Purchase quantity cannot be zero!")
        }
        
        /// Whether the purchased number is less than the repo number.
        ///     If true, keep going.
        ///     Otherwise, return error info.
        guard(number <= ticket.quantity ) else{
            return (nil,"Purchase quantity is not available!")
        }
        
        /// Updates quantity by deducting the purchased number.
        ticket.quantity -= number
        
        /// Creates a record and appends to record list.
        recordList.append(
            Record(ticketName:ticket.name, purchasedNumber: number,ticketPrice: ticket.price))
        
        
        return ("Sucess purchase \(number) ticket(s).",nil)
    }
    
    /**
     Gets cost of purchasing a given number tickets at a index.
     - Parameters:
        - index: The index where a ticket locates in the ticket list.
        - number: The number of purchased ticket.
     - Returns: A string of cost information.
     
     */
    func getCost(index:Int, number:Int) -> String{
        
        /// The object of ticket at the given index.
        let ticket = self.ticketList[index]
        
        /// Calculates the cost.
        return "\(ticket.price * Double(number))"
    }
    
    /**
     Updates the repo quantity of a ticket at an index.
     
     - Parameters:
        - index: The index where the ticket locates in the ticket list.
        - newQuantity: The new quantity to be set.
     
     - Returns: A bool.
     */
    func updateTicket(index:Int, newQuantity:Int) -> (String){
        
        /// The object of ticket at the given index.
        let ticket = self.ticketList[index]
        
        /// Updates the quantity.
        ticket.quantity = newQuantity
        
        return "Update \(ticket.name)'s quantity successfully!"
    }
    
    /**
     Reset the repo quantity of a ticket
     
     - Parameters:
     - Returns: A String of message.
     */
    func resetTicket() -> (String){
        ticketList = [
            Ticket(name: "Balcony", quantity: 12, price: 1170),
            Ticket(name: "Lower", quantity: 20, price: 10434),
            Ticket(name: "Courtside", quantity: 15, price: 27777)
        ]
        return "Reset all ticket quantities successfully!"
    }
}
