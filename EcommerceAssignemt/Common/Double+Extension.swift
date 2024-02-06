//
//  Double+Extension.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation

extension Double {
    var priceFormatted: String {
        let amount = Double(self)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "tr-TR")
        return numberFormatter.string(from: NSNumber(value: amount)) ?? "0"
        
    }
}
