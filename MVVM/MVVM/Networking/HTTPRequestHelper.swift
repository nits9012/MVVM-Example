//
//  HTTPRequestHelper.swift
//  MVVM
//
//  Created by Nitin Bhatt on 2/11/22.
//

import Foundation

struct ServiceError: Error,Codable {
    let message: String
}

class HTTPRequestHelper{
    func getRequest(url:String,params: [String:String],completion: @escaping (Bool,Data?,ServiceError?)->()){
        
        guard var components = URLComponents(string: url) else {
            print("Error creating Url componenets")
            return
        }
        
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else{
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        request.timeoutInterval = 5
        
        session.dataTask(with: request){data,response,error in
            if let httpResponse = response as? HTTPURLResponse {
                guard error == nil else {
                    completion(false,nil, ServiceError(message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                    return
                }
                
                guard let data = data else{
                    completion(false,nil, ServiceError(message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                    return
                }
                
                guard (200..<300) ~= httpResponse.statusCode else {
                    completion(false,nil, ServiceError(message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                    return
                }
                completion(true,data, nil)
            }else{
                if (error as? URLError)?.code == .timedOut {
                    // Handle session timeout
                    completion(false,nil, ServiceError(message: error?.localizedDescription ?? "Unknown Error"))
                }else{
                    completion(false,nil, ServiceError(message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                }
            }
            
        }.resume()
    }
}
