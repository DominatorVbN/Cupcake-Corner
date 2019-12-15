//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by dominator on 11/12/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.orderItem.type){
                        ForEach(0..<OrderItem.types.count, id: \.self) {
                            Text(OrderItem.types[$0])
                        }
                    }
                    Stepper("Number of cake \(order.orderItem.quantity)", value: $order.orderItem.quantity, in: 3...20)
                }
                Section{
                    Toggle(isOn: $order.orderItem.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    if order.orderItem.specialRequestEnabled{
                        Toggle(isOn: $order.orderItem.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.orderItem.addSprinkles){
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section{
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }.navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
