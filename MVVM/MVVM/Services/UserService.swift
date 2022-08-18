//
//  UserService.swift
//  MVVM
//
//  Created by Nitin Bhatt on 2/12/22.
//

import Foundation

protocol UserServiceProtocol {
    func getUsers(completion: @escaping (_ success:Bool,_ results:Users?,_ _errorMessage:String?)-> ())
}

class UserService:UserServiceProtocol{
    
    var httpClient: HTTPRequestHelper?
    
    init(client: HTTPRequestHelper) {
        self.httpClient = client
    }
    
    func getUsers(completion: @escaping (Bool,Users?,String?)->()){
        let getUserUrlString =  APIPath().users
        
        httpClient?.getRequest(url: getUserUrlString, params: ["":""], completion: {success,data,error  in
            if success{
                do{
                    let users = try JSONDecoder().decode(Users.self, from: data!)
                    completion(true,users, nil)
                    
                }catch let error as NSError{
                    completion(false,nil, error.localizedDescription)
                }
            }else{
                completion(false, nil, error?.message ?? "Unkown error")
            }
        })
    }
}
