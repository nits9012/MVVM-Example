//
//  APIPath.swift
//  MVVM
//
//  Created by Nitin Bhatt on 8/16/22.
//

#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.production
#endif

let baseURL = environment.baseURL()

struct APIPath {
    var users: String { return "\(baseURL)/users"}
}


