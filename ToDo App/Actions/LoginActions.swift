//
//  LoginActions.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation
import ReSwift

extension LoginState {
    public static func loginCheck(email: String, password: String) -> LoginValidate {
        if email.trimText.isEmpty && !email.isValidEmail {
            mainStore.dispatch(LoginValidateAction(emailValid:false, passwordValid:true))
        } else if password.isEmpty && !password.isValidPassword {
            mainStore.dispatch(LoginValidateAction(emailValid:true, passwordValid:false))
        } else {
            mainStore.dispatch(LoginValidateAction(emailValid:true, passwordValid:true))
        }
        
        return LoginValidate()
    }
}

struct LoginValidate: Action {}

struct LoginValidateAction: Action {
    let emailValid: Bool
    let passwordValid: Bool
}
