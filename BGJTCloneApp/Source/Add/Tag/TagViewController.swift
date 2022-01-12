//
//  TagViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/12.
//

import UIKit

protocol TagDelegate {
    func tagViewDismissed(tags: [String])
}
class TagViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var delegate: TagDelegate?
    
    //태그 데이터 5개 이상 추가 불가.
    var tags: [String] = [] {
        didSet {
            if tags.count > 5 {
                tags.popLast()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagTextField.delegate = self
        tagTextField.addDoneButtonOnKeyboard()
        
        collectionView.contentInset.left = 10
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.dismissKeyboardWhenTappedAround()
    }
    
    @IBAction func addButtonTap(_ sender: UIButton) {
        
        if let tag = tagTextField.text {
            //추가시 중복 검사
            if tags.contains(tag) {
                //nothing
            } else {
                tags.append(tag)
            }
        }
        tagTextField.text = nil
        collectionView.reloadData()
    }
    
    
    @IBOutlet weak var tagTextField: UITextField!
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent {
          
            delegate?.tagViewDismissed(tags: tags)
        }
    }
}

//MARK: - 텍스트 필드 글자수 제한 9개까지.
extension TagViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 9
    }
}



//MARK: - 태그 컬렉션 뷰 Data Source
extension TagViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! TagCollectionViewCell
        
        cell.tagLabel.text = "#" + tags[indexPath.row]
        cell.tagLabel.layer.masksToBounds = true
        cell.tagLabel.layer.cornerRadius = 2
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
}

//MARK: - 태그 셀 제거 버튼 Delegate
extension TagViewController: TagCellDelegate {
    func cellDidSelected(index: Int) {
        
        tags.remove(at: index)
        collectionView.reloadData()
    }
}

//MARK: - 태그 컬렉션 뷰 셀에 따라 동적으로 Layout 수정.
extension TagViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! TagCollectionViewCell
        
        cell.tagLabel.text = tags[indexPath.row]
        cell.tagLabel.sizeToFit()
        
        //셀의 크기를 Label 크기 + 50(= 삭제 버튼을 위한 inset)
        let cellWidth = cell.tagLabel.frame.width + 50
        return CGSize(width: cellWidth, height: 30)
    }
}

