//
//  HTTPRequestHelper.swift
//  MVVM
//
//  Created by Nitin Bhatt on 2/11/22.
//

import Foundation


class HTTPRequestHelper{
    func getRequest(url:String,params: [String:String],completion: @escaping (Bool,Data?)->()){
        
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
        
        
        session.dataTask(with: request){data,response,error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                completion(false, nil)
                return
            }
            
            guard let data = data else{
                print("Didn't receive data")
                completion(false, nil)
                return
            }
                       
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("HTTP request failed")
                completion(false, nil)
                return
            }
            
            completion(true,data)
        }.resume()
    }
}
