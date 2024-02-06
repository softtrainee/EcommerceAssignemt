//
//  Session.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation

class Session {
    
    static let shared = Session()
    var currentBasketCount: Int? {
        didSet {
            UserDefaults.standard.setValue(currentBasketCount, forKey: "currentBasketCount")
        }
    }

    var basketCountNotification: Int? {
        didSet {
            UserDefaults.standard.setValue(basketCountNotification, forKey: "basketCountNotification")
        }
    }
    
}

