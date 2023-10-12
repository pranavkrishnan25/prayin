//
//  cosmos-test.swift
//  notbs
//
//  Created by Atin Pothiraj on 8/22/23.
//

import SwiftUI

struct cosmos_test : View {
    private let cosmosDBService = CosmosDBService()

    var body: some View {
        Button("Add Document") {
            let document: [String: Any] = ["id": UUID().uuidString, "userID": "john"]
            cosmosDBService.createDocument(in: "Container1", databaseId: "thelyx", document: document) { result in
                switch result {
                case .success(let data):
                    print("Document created!")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}


struct cosmos_test_Previews: PreviewProvider {
    static var previews: some View {
        cosmos_test()
    }
}
