//
//  UserViewModel.swift
//  MVVM
//
//  Created by Nitin Bhatt on 2/13/22.
//

import Foundation

class UserViewModel:NSObject{
    
    private var userService:UserServiceProtocol
    var users = Users()
    
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
    }
    
    func getUsers(){
        self.userService.getUsers(completion: {success,results,error in
            if success, let values = results {
                self.fetchUserData(users: values)
            }else{
                print(error)
            }
        })
    }
    
    func fetchUserData(users: Users) {
        self.users = users // Cache
        var userCell = [UserCellViewModel]()
  
        for user in users {
            userCell.append(createCellModel(user: user))
        }
        //employeeCellViewModels = vms
    }
    
//    func createCellModel(user: User) -> UserCellViewModel {
//        let id = user.id
//        let name = user.employeeName
//        let email = user.employeeEmail
//        let gender = user.employeeGender
//        
//        return UserCellViewModel(id: id, name: name, email: email, gender: gender)
//    }
//    

}
