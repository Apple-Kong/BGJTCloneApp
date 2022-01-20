//
//  OptionChoiceViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import UIKit

protocol OptionDelegate {
    func optionChoosed(nuberOfItem: Int, isOld: Bool, isExchangable: Bool)
}

class OptionChoiceViewController: UIViewController {
    
    var delegate: OptionDelegate?
    
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    var isKeyBoardShown = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var numberBackView: UIView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var oldButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var noExchangeButton: UIButton!
    @IBOutlet weak var yesExchangeButton: UIButton!
    @IBOutlet weak var completButton: UIButton!
    
    var numberOfItem: Int = 1
    var isOld: Bool = true
    var isExchangable: Bool = false
    
    @IBAction func stateChanged(_ sender: UIButton) {
        if sender == self.oldButton {
            oldButton.isSelectedColoring(isSelected: true)
            newButton.isSelectedColoring(isSelected: false)
            isOld = true
        } else {
            oldButton.isSelectedColoring(isSelected: false)
            newButton.isSelectedColoring(isSelected: true)
            isOld = false
        }
    }
    
    @IBAction func exchangeTapped(_ sender: UIButton) {
        if sender == self.noExchangeButton {
            noExchangeButton.isSelectedColoring(isSelected: true)
            yesExchangeButton.isSelectedColoring(isSelected: false)
            isExchangable = false
        } else {
            noExchangeButton.isSelectedColoring(isSelected: false)
            yesExchangeButton.isSelectedColoring(isSelected: true)
            isExchangable = true
        }
    }
    
    @IBAction func completeButtonTap(_ sender: UIButton) {
        self.dismiss(animated: true) {
            //수정 필요 데이터 전달.
            if let numString = self.numberTextField.text {
                let num = Int(numString) ?? 1
                if num < 1 {
                    self.numberOfItem = 1
                } else {
                    self.numberOfItem = num
                }
            }
            self.delegate?.optionChoosed(nuberOfItem: self.numberOfItem, isOld: self.isOld, isExchangable: self.isExchangable)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        numberTextField.text = "\(numberOfItem)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberBackView.roundedBorder()
        numberTextField.addDoneButtonOnKeyboard()
        numberTextField.delegate = self
        self.dismissKeyboardWhenTappedAround()
        
        oldButton.roundedBorder()
        oldButton.isSelectedColoring(isSelected: true)
        newButton.roundedBorder()
        newButton.isSelectedColoring(isSelected: false)
        noExchangeButton.roundedBorder()
        noExchangeButton.isSelectedColoring(isSelected: true)
        yesExchangeButton.roundedBorder()
        yesExchangeButton.isSelectedColoring(isSelected: false)
        
        completButton.layer.masksToBounds = true
        completButton.layer.cornerRadius = 5
        completButton.tintColor = UIColor(named: "badge")
        completButton.titleLabel?.tintColor = .white
        
    }
    @IBAction func addItemButtonTap(_ sender: UIButton) {
    }
}

//MARK: - 텍스트 필드 편집시 애니메이션
extension OptionChoiceViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //해당 텍스트 필드 입력 시작시
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 3
    }
    
    
    //텍스트 필드 입력 종료시
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}



extension OptionChoiceViewController {
    // 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if !isKeyBoardShown {
                isKeyBoardShown = true
                self.buttonStackView.window?.frame.origin.y -= keyboardHeight - 60
               
                leading.constant = -10
                trailing.constant = -10
            }
           
           
            
        }
        
    } // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if isKeyBoardShown {
                isKeyBoardShown = false
                self.buttonStackView.window?.frame.origin.y += keyboardHeight - 60
                leading.constant = 30
                trailing.constant = 30
             
            }
            

        }
    }
}




