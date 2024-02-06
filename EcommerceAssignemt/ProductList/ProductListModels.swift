//
//  ProductListModels.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

enum ProductList
{
    struct ProductModel: Identifiable, Codable {
        var id: Int?
        var title: String?
        var description: String?
        var brand: String?
        var category: String?
        var rating: String?
        var imageUrl: [String]?
        var price: Double?
        var count: Int?
    }
}

extension ProductList.ProductModel {
    init(from dict: [String: Any]) {
        id = dict["id"] as? Int
        title = dict["title"] as? String
        price = dict["price"] as? Double
        description = dict["description"] as? String
        brand = dict["brand"] as? String
        category = dict["category"] as? String
        rating = dict["rating"] as? String
        imageUrl = dict["images"] as? [String]
        count = dict["count"] as? Int
    }
}

 
