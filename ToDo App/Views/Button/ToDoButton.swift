//
//  ToDoButton.swift
//

import UIKit

final class ToDoButton: UIButton {

    @IBInspectable var isFilled: Bool = true {
        didSet {
            setupUI()
        }
    }

    private var bgColor: UIColor {
        return isFilled ? R.color.global_blue()! : .white
    }

    private var foregoundColor: UIColor {
        return isFilled ? R.color.global_yellow()! : R.color.global_blue()!
    }

    private var actionHandler: (() -> Void)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // UIButton for dynamic creation
    init(withButton button: AlertButton) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(button.title, for: .normal)
        self.actionHandler = button.actionHandler
        addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        setupUI()
    }
    
    private func setupUI() {
        self.cornerRadius = 8.0
        self.borderWidth = isFilled ? 0 : 1
        self.borderColor = R.color.global_blue()
        setState(enabled: true)
    }

    func setState(enabled: Bool) {
        if enabled {
            self.backgroundColor = bgColor
            self.setTitleColor(foregoundColor, for: .normal) 
            self.layer.shadowOpacity = 0
        } else {
            self.backgroundColor = R.color.light_gray()
            self.setTitleColor(R.color.gray(), for: .normal)
        }
        self.isUserInteractionEnabled = enabled
    }
    
    @objc func didTapButton() {
        self.actionHandler?()
    }
}
