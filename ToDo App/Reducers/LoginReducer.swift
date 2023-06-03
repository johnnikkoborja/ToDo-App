//
//  LoginReducer.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation
import ReSwift

func loginReducer(action: Action, loginState: LoginState?) -> LoginState {
    var state = loginState ?? LoginState()

    switch action {
    case let action as LoginValidateAction:
        state.emailValid = action.emailValid
        state.passwordValid = action.passwordValid
        break
    default:
        break
    }

    return state
}
