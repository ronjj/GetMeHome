//
//  Date+Extension.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/13/24.
//

import Foundation

//Need this extension to use Dates with AppStorage
//App Storage doesn't support Date types natively
//This code uses ISO8601DateFormatter to format a date to String and map it back.
//That formatter is static because creating and removing DateFormatters is an expensive operation.
extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
