//
//  ContentView.swift
//  Fetch Data API
//
//  Created by Yani . on 26/11/21.
//

import SwiftUI

struct ContentView: View {

    @State var results : [TaskEntry] = []

    var body: some View {
        NavigationView {
            List(results, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                }
            }
            .onAppear(perform: loadData)
            .navigationBarTitle("Fetch Data API")
        }
    }

    func loadData() {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode([TaskEntry].self, from: data) {
                        DispatchQueue.main.async {
                            self.results = response
                        }
                        return
                    }
                }
            }.resume()
        }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
