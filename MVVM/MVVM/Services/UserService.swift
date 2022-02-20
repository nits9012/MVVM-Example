//
//  UserService.swift
//  MVVM
//
//  Created by Nitin Bhatt on 2/12/22.
//

import Foundation

protocol UserServiceProtocol {
    func getUsers(completion: @escaping (_ success:Bool,_ results:Users?,_ _error:String)-> ())
}

class UserService:UserServiceProtocol{
    func getUsers(completion: @escaping (Bool,Users?,String)->()){
        HTTPRequestHelper().getRequest(url: "https://gorest.co.in/public/v2/users", params: ["":""], completion: {success,data in
            if success{
                do{
                    let users = try JSONDecoder().decode(Users.self, from: data!)
                    completion(true,users, "")

                }catch let error as NSError{
                    completion(false,nil,"Error while parsing data \(error)")
                }
            }else{
                completion(false, nil, "Error: Employees GET Request failed")
            }
        })
    }
}
