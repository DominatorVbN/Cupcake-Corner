//
//  Ordewr.swift
//  Cupcake Corner
//
//  Created by dominator on 15/12/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

class Order: ObservableObject{
    static let types = ["Vanila", "Stawberry", "Choclate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false{
        didSet{
            if !specialRequestEnabled{
                extraFrosting = false
                extraSpriklss = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var extraSpriklss = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool{
        !(name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty)
    }
    
    var cost: Double{
        
        //2$ per cake
        var cost = Double(quantity) * 2
        
        //complicated cake cost more
        cost += Double(type)/2
        
        //$1 per cake for extra frosting
        if extraFrosting{
            cost += Double(quantity)
        }
        
        // 50 cents per cake for extra sprinkled
        if extraSpriklss{
            cost += Double(quantity)/2
        }
        
        return cost
    }
}
