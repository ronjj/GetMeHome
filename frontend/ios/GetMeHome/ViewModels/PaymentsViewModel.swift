//
//  PaymentsViewModel.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 3/16/24.
//

import Observation
import SwiftUI

@Observable class PaymentsViewModel {
    
    func makePayment() {
        guard let url = URL(string: "http://127.0.0.1:5000/buy_ticket") else { return }
        
        print("making payment request")
        
        var request = URLRequest(url: url)
        //        method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "name": "Ronald",
            "email": "roaldjabouin2004@gmail.com",
            "bus_service": "OurBus",
            "date": "4/20/2024",
            "origin": "Ithaca",
            "destination": "New York",
            "ticket_price": "55.0",
            "commission": "4.0",
            "link_to_buy": "https://www.google.com"
            
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
