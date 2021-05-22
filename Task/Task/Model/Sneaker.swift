//
//  Sneaker.swift
//  Task
//
//  Created by Yersultan Nalikhan on 22.05.2021.
//

import Foundation

struct Sneaker {
    let brand: String
    let gender: String
    let price: String
    
    static func GetAllSneakers() -> [Sneaker] {
        
        return [
            Sneaker(brand: "Nike", gender: "Men", price: "100"),
            Sneaker(brand: "Adidas", gender: "Women", price: "200"),
            Sneaker(brand: "Jordan", gender: "Men", price: "300"),
            Sneaker(brand: "Puma", gender: "Child", price: "200"),
            Sneaker(brand: "Under Armour", gender: "Women", price: "90"),
            Sneaker(brand: "Reebok", gender: "Child", price: "-"),
            Sneaker(brand: "Vans", gender: "Men", price: "-"),
        ]
        
    }

}


