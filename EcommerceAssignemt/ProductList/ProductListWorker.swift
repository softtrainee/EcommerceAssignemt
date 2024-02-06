//
//  ProductListWorker.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit
import Alamofire

class ProductListWorker
{
    
    func fecthProducts(completion: @escaping ((_ productModel: [ProductList.ProductModel]?)-> ())) {
        var products: [ProductList.ProductModel] = []
        
        
        Alamofire.request("https://dummyjson.com/products").responseJSON { response in
            
            if(response.response?.statusCode == 200){
                if let json = response.result.value as AnyObject? {
                    let arrayResponse = json["products"] as! NSArray
                    for product in arrayResponse {
                        if let productDict = product as? Dictionary<String, AnyObject> {
                            
                            let viewModel = ProductList.ProductModel(from: productDict)
                            
                            products.append(viewModel)
                            
                        }
                    }
                }
                completion(products)
            }
        }
        
        
    }
    
    func fetchBaskets(completion: @escaping ((_ productModel: [ProductList.ProductModel]?)-> ())) {
        var products: [ProductList.ProductModel] = []
        products.removeAll()
        
        Alamofire.request("https://dummyjson.com/carts").responseJSON { response in
            
            if(response.response?.statusCode == 200){
                if let json = response.result.value as AnyObject? {
                    let arrayResponse = json["products"] as! NSArray
                    for product in arrayResponse {
                        if let productDict = product as? Dictionary<String, AnyObject> {
                            
                            let viewModel = ProductList.ProductModel(from: productDict)
                            
                            products.append(viewModel)
                            
                        }
                    }
                }
                completion(products)
            }
        }
    }
    
    func addBasket(product: ProductList.ProductModel?, piece: Int?, completion: @escaping ((_ isAdded: Bool?)-> ())) {
        
 
    }
    func fetchSearchProduct(_ searchText: String?, completion: @escaping ((_ productModel: [ProductList.ProductModel]?)-> ())) {
        guard let text = searchText else { return }
        
        var products: [ProductList.ProductModel] = []
        
        
        Alamofire.request("https://dummyjson.com/products").responseJSON { response in
            
            if(response.response?.statusCode == 200){
                if let json = response.result.value as AnyObject? {
                    let arrayResponse = json["products"] as! NSArray
                    for product in arrayResponse {
                        if let productDict = product as? Dictionary<String, AnyObject> {
                            
                            let viewModel = ProductList.ProductModel(from: productDict)
                            
                            products.append(viewModel)
                            
                        }
                    }
                    products = products.filter({ product in
                        guard let productTitle = product.title else {
                            return false
                        }
                        return (productTitle.lowercased().contains(text.lowercased()))
                    })
                }
                completion(products)
            }
            
        }
        
    }
}
