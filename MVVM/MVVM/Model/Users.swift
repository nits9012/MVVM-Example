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
    var employeeEmail:String
    var employeeGender:String
    var employeeName:String
    var employeeStatus:String
    
    enum CodingKeys:String,CodingKey{
        case id
        case employeeEmail = "email"
        case employeeGender = "gender"
        case employeeName = "name"
        case employeeStatus = "status"
    }
}
