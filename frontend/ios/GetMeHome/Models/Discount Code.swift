//
//  Discount Code.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 12/29/23.
//

import SwiftUI

struct DiscountWrapper: Codable {
    let discountCodes: [Discount]
}

struct Discount: Identifiable, Hashable, Codable {
    let id: Int
    let service: String
    let code: String
}
