//
//  AppReducer.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        loginState: loginReducer(action: action, loginState: state?.loginState),
        todoResultState: todoResultReducer(action: action, toDoResultState: state?.todoResultState),
        todoDetailState: todoDetailReducer(action: action, toDoDetailState: state?.todoDetailState)
    )
}
