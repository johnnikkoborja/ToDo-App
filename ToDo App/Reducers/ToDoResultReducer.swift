//
//  ToDoResultReducer.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation
import ReSwift

func todoResultReducer(action: Action, toDoResultState: ToDoResultState?) -> ToDoResultState {
    var state = toDoResultState ?? ToDoResultState()

    switch action {
    case let action as ToDoListAction:
        state.todoList = action.todoList
        break
    default:
        break
    }

    return state
}
