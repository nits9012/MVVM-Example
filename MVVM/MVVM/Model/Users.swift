//
//  Users.swift
//  MVVM
//
//  Created by Nitin Bhatt on 2/11/22.
//

import Foundation

typealias Users = [User]


struct User:Decodable{
    var id:Int
    var userEmail:String?
    var userGender:String?
    var userName:String?
    var userStatus:String?
    
    enum CodingKeys:String,CodingKey{
        case id
        case userEmail = "email"
        case userGender = "gender"
        case userName = "name"
        case userStatus = "status"
    }
}
