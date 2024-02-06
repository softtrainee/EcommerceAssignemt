//
//  BasketsWorker.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit


class BasketsWorker
{
 
    func fetchBaskets(completion: @escaping ((_ productModel: [ProductList.ProductModel]?)-> ())) {
        var products: [ProductList.ProductModel] = []
        products.removeAll()
 
    }
    
    func deleteBaskets(completion: @escaping ((_ deleted: Bool?)-> ())) {
 
    }
}
