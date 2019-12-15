//
//  Ordewr.swift
//  Cupcake Corner
//
//  Created by dominator on 15/12/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

class Order: ObservableObject{
    @Published var orderItem = OrderItem()
}

struct OrderItem: Codable{
    static let types = ["Vanila", "Stawberry", "Choclate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false{
        didSet{
            if !specialRequestEnabled{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool{
        !(name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty)
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
        if addSprinkles{
            cost += Double(quantity)/2
        }
        
        return cost
    }
}
