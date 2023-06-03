//
//  ToDoDetailReducer.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation
import ReSwift

func todoDetailReducer(action: Action, toDoDetailState: ToDoDetailState?) -> ToDoDetailState {
    var state = toDoDetailState ?? ToDoDetailState()
    
    switch action {
    case let action as ModifyToDoListAction:
        state.errorMessage = action.errorMessage
        break
    default:
        break
    }

    return state
}
