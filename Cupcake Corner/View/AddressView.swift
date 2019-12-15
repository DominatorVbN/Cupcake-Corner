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
        HStack {
            Form{
                Section{
                    TextField("Name", text: $order.orderItem.name)
                    TextField("Street address", text: $order.orderItem.streetAddress)
                    TextField("City", text: $order.orderItem.city)
                    TextField("Zip", text: $order.orderItem.zip)
                }
                Section {
                    NavigationLink(destination: CheckOutView(order: order)) {
                        Text("Checkout")
                    }
                }.disabled(!order.orderItem.hasValidAddress)
            }
        }.navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
