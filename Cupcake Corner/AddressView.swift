//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by dominator on 15/12/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Text("Hello, World!")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
