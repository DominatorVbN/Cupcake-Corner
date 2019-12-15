//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by dominator on 11/12/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI
struct Response: Codable{
    let results : [Result]
}
struct Result: Codable{
    let trackId: Int
    let trackName: String
    let collectionName: String
}
struct ContentView: View {
    @State var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }.onAppear(perform: loadData)
    }
    func loadData(){
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else{
            print("invalid URl")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                if let decodedData = try? JSONDecoder().decode(Response.self, from: data){
                    DispatchQueue.main.async{
                        self.results = decodedData.results
                    }
                    return
                }
            }
            print("error",error as Any)
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
