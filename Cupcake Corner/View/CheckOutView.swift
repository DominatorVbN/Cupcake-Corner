//
//  CheckOutView.swift
//  Cupcake Corner
//
//  Created by dominator on 15/12/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    @State var confirmationMessage = ""
    @State var confirmationTitle = ""
    @State var showingConfirmation = false
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your total is $\(self.order.orderItem.cost, specifier: "%.2f")").font(.title)
                    Button("Place order", action: self.placeOrder)
                        .padding()
                }
            }
        }.navigationBarTitle("Check out", displayMode: .inline)
            .alert(isPresented: $showingConfirmation) {
                Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    func placeOrder(){
        
        guard let encoded = try? JSONEncoder().encode(order.orderItem) else{
            print("Unable to encode")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                self.confirmationTitle = "Error"
                self.confirmationMessage = (error?.localizedDescription ?? "Unknown error")
                self.showingConfirmation = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(OrderItem.self, from: data){
                 self.confirmationTitle = "Thank you!"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderItem.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            }else{
                self.confirmationTitle = "Error"
                self.confirmationMessage = "Invalid response from server"
                self.showingConfirmation = true
            }
        }.resume()
        
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
