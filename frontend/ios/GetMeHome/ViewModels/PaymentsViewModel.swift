//
//  PaymentsViewModel.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 3/16/24.
//

import Observation
import SwiftUI

@Observable class PaymentsViewModel {
    
    func makePayment(date: String, price: String, dep: String, depTime: String, dest: String, destTime: String, bus: String, name: String, email: String,  commission: String, ticketLink: String) {
        guard let url = URL(string: "http://127.0.0.1:5000/buy_ticket") else { return }
        
        print("making payment request")
        
        var request = URLRequest(url: url)
        //        method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "name": name,
            "email": email,
            "bus_service": bus,
            "date": date,
            "dep": dep,
            "dep_time": depTime,
            "destination": dest,
            "destination_time": destTime,
            "ticket_price": price,
            "commission": commission,
            "link_to_buy": ticketLink
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        //        Make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("Success: \(response)")
            } catch {
                print(error)
            }
        }
        
        //        Valid response code
        task.resume()
    }
   
}
