//
//  AppState.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var loginState: LoginState = LoginState()
    var todoResultState: ToDoResultState = ToDoResultState()
    var todoDetailState: ToDoDetailState = ToDoDetailState()
}
