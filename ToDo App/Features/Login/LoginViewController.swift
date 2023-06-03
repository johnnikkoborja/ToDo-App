//
//  LoginViewController.swift
//

import Foundation
import UIKit
import ReSwift

final class LoginViewController: BaseViewController, StoreSubscriber {
    
    @IBOutlet private weak var emailTextField: ToDoTextField!
    @IBOutlet private weak var passwordTextField: ToDoTextField!
    @IBOutlet private weak var loginButton: ToDoButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        if (self.navigationController?.topViewController != self) {
            return
        }
        
        guard let isEmailValid = state.loginState.emailValid else { return }
        guard let isPasswordValid = state.loginState.passwordValid else { return }
        
        if !isEmailValid {
            emailTextField.errorLabel.text = R.string.localizable.loginInvalidEmail()
            emailTextField.errorLabel.isHidden = false
        } else {
            emailTextField.errorLabel.isHidden = true
        }
        
        if !isPasswordValid {
            emailTextField.errorLabel.text = R.string.localizable.loginInvalidEmail()
            emailTextField.errorLabel.isHidden = false
        } else {
            emailTextField.errorLabel.isHidden = true
        }
        
        let isValid = isEmailValid && isPasswordValid
        if isValid {
            goToHomeVC()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.inputTextField.delegate = self
        passwordTextField.inputTextField.delegate = self
    }
    
    @IBAction private func loginPressed(_ sender: UIButton) {
        let email = emailTextField.trimText
        let password = passwordTextField.trimText
        mainStore.dispatch(LoginState.loginCheck(email: email, password: password))
        emailTextField.inputTextField.resignFirstResponder()
        passwordTextField.inputTextField.resignFirstResponder()
    }

    private func goToHomeVC() {
        var updatedList: UserList?
        
        // Getting list
        updatedList = TaskManager.getUserList()
        let isExisting = TaskManager.checkUser(email: emailTextField.trimText, userList: updatedList)
        if !isExisting {
            let user = User.init(email: emailTextField.trimText, todoList: nil)
            updatedList?.userList?.append(user)
            
            // Write List
            TaskManager.writeUsers(userList: updatedList)
        }
        UserDefaultsManager.setValue(key: R.string.localizable.userEmailId(), value: emailTextField.trimText)
        
        let homeScreen = R.storyboard.toDoResult.toDoResultViewController()!
        navigationController?.pushViewController(homeScreen, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if emailTextField.errorLabel.isHidden == false {
            emailTextField.errorLabel.isHidden = true
        }
        
        if passwordTextField.errorLabel.isHidden == false {
            passwordTextField.errorLabel.isHidden = true
        }
    }
}
