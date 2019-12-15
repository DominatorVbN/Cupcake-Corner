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
}
