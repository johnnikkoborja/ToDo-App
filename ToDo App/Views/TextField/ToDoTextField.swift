//
//  ToDoTextField.swift
//

import UIKit
import RxSwift
import RxCocoa

final class ToDoTextField: UIControl {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet private weak var inputLabel: UILabel!
    @IBOutlet private weak var inputTextView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var isValid = BehaviorRelay<Bool>(value: false)
    var error = BehaviorRelay<String?>(value: nil)
    
    var trimText: String {
        return inputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        self.errorLabel.isHidden = true
    }
    
    @IBInspectable var textFieldLabel: String = "" {
        didSet {
            inputLabel.text = textFieldLabel.localized
        }
    }
    
    @IBInspectable var errorText: String = "" {
        didSet {
            errorLabel.text = errorText.localized
        }
    }
    
    @IBInspectable var textFieldPlaceholder: String = "" {
        didSet {
            inputTextField.attributedPlaceholder = NSAttributedString(string: textFieldPlaceholder.localized,
                                                                      attributes: [NSAttributedString.Key.foregroundColor : R.color.textfield_placeholder()!])
        }
    }
    
    @IBInspectable var isPasswordField: Bool = false {
        didSet {
            inputTextField.isSecureTextEntry = isPasswordField
            inputTextField.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    @IBInspectable var isEmailField: Bool = false {
        didSet {
            inputTextField.keyboardType = isEmailField ? .emailAddress : .default
            inputTextField.autocorrectionType = isEmailField ? .no : .default
            inputTextField.autocapitalizationType = isEmailField ? .none : .sentences
        }
    }
    
    @IBInspectable var isRequired: Bool = false
    
    private func hasValidEmail() -> Bool {
        guard inputTextField.text?.isValidEmail == true else { return false }
        return true
    }
    
    private func hasValidPassword() -> Bool {
        guard inputTextField.text?.isValidPassword == true else { return false }
        return true
    }
    
    func configureSubscriptions(disposeBag: DisposeBag) {
        if isRequired && isEmailField {
            inputTextField.rx.controlEvent([.editingChanged])
                .asObservable()
                .subscribe(onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.isValid.accept(!self.trimText.isEmpty && self.hasValidEmail())
                    if !self.isEmailField { return }
                    if self.isValid.value {
                        self.errorLabel.isHidden = true
                    } else  {
                        self.errorLabel.text = R.string.localizable.loginInvalidEmail()
                        self.errorLabel.isHidden = false
                    }
                })
                .disposed(by: disposeBag)
        } else if isRequired && isPasswordField {
            inputTextField.rx.controlEvent([.editingChanged])
                .asObservable()
                .subscribe(onNext: { [unowned self] _ in
                    self.isValid.accept(!self.trimText.isEmpty && self.hasValidPassword())
                    if self.isValid.value {
                        self.errorLabel.isHidden = true
                    } else {
                        self.errorLabel.text = R.string.localizable.loginWrongPassword()
                        self.errorLabel.isHidden = false
                    }
                })
                .disposed(by: disposeBag)
        } else if isRequired {
            inputTextField.rx.controlEvent([.editingChanged])
                .asObservable()
                .subscribe(onNext: { [unowned self] _ in
                    self.isValid.accept(!self.trimText.isEmpty)
                    if self.isValid.value {
                        self.errorLabel.isHidden = true
                    } else {
                        self.errorLabel.text = errorText.localized
                        self.errorLabel.isHidden = false
                    }
                })
                .disposed(by: disposeBag)
        }

        error.asObservable()
            .skip(1)
            .subscribe(onNext: { [unowned self] errorText in
                guard let errorText = errorText else {
                    self.errorLabel.isHidden = true
                    self.isValid.accept(true)
                    return
                }
                if !errorText.isEmpty {
                    self.isValid.accept(false)
                    self.errorLabel.text = errorText
                    self.errorLabel.isHidden = false
                }
            })
            .disposed(by: disposeBag)
    }
}
