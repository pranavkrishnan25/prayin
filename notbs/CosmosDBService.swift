//
//  CosmosDBService.swift
//  thelyx-alpha
//
//  Created by Atin Pothiraj on 8/22/23.
//

import Foundation
import Alamofire // If you're using Alamofire
import CryptoKit

class CosmosDBService {
    private let accountName = "thelyxdb"
    private let accountKey = "rfhFIBsJ8kJXXfz0OIJOg8OTnR7MUvmMxyP5lTKAWAFVCiYmE9I6pJjqKiQV5UswBwnHEP1pFD65ACDbMBHwIw=="
    private let baseUrl = "https://thelyxdb.documents.azure.com:443/"
    
    // Add other necessary configurations
    
    
    private func generateAuthHeader(verb: HTTPMethod, resourceType: String, resourceId: String) -> String {
        let masterToken = "master"
        let tokenVersion = "1.0"
        
        let date = DateFormatter().rfc1123String(from: Date())
        
        let signature = generateSignature(verb: verb.rawValue.uppercased(), resourceId: resourceId, resourceType: resourceType, date: date, key: accountKey, keyType: masterToken, tokenVersion: tokenVersion)
        
        let authHeader = "type=\(masterToken)&ver=\(tokenVersion)&sig=\(signature)"
        
        return authHeader
    }
    
    private func generateSignature(verb: String, resourceId: String, resourceType: String, date: String, key: String, keyType: String, tokenVersion: String) -> String {
        var text = verb.lowercased() + "\n"
        text += resourceType.lowercased() + "\n"
        text += resourceId + "\n"
        text += date.lowercased() + "\n"
        text += "" + "\n"
        
        let keyData = Data(base64Encoded: key, options: [])!
        let textData = text.data(using: .utf8)!
        
        let hmac = HMAC<SHA256>.authenticationCode(for: textData, using: SymmetricKey(data: keyData))
        let base64HMAC = Data(hmac).base64EncodedString()
        
        let authComponent = base64HMAC.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        
        return authComponent
    }
    
    
    func createDocument(in collectionId: String, databaseId: String, document: [String: Any], completion: @escaping (Result<Data?, AFError>) -> Void) {
        let resourceType = "docs"
        let resourceId = "dbs/\(databaseId)/colls/\(collectionId)"
        let endpoint = "\(baseUrl)dbs/\(databaseId)/colls/\(collectionId)/docs"
        
        guard let partitionKeyValue = document["userID"] as? String else {
            print("Error: Missing userID in document.")
            return
        }
        
        var headers: HTTPHeaders = [
            "x-ms-date": DateFormatter().rfc1123String(from: Date()),
            "x-ms-version": "2018-12-31",
            "authorization": generateAuthHeader(verb: .post, resourceType: resourceType, resourceId: resourceId),
            "Content-Type": "application/json"
        ]
        headers["x-ms-documentdb-partitionkey"] = "[\"\(partitionKeyValue)\"]" // The value should be in a JSON array format
        
        AF.request(endpoint, method: .post, parameters: document, encoding: JSONEncoding.default, headers: headers).response { response in
            if let data = response.data, let string = String(data: data, encoding: .utf8) {
                print("Response from Cosmos DB: \(string)")
            }
            completion(response.result)
        }
    }

}
extension DateFormatter {
    func rfc1123String(from date: Date) -> String {
        self.dateFormat = "E, dd MMM yyyy HH:mm:ss 'GMT'"
        self.timeZone = TimeZone(abbreviation: "GMT")
        self.locale = Locale(identifier: "en_US")
        return self.string(from: date)
    }
}
