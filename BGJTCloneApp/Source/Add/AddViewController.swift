//
//  AddViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import UIKit

class AddViewController: UIViewController {
    
    let addManager = AddManager()
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
           
        }
    }
    //이미지 피커
    let picker = UIImagePickerController()
    var selectedImages: [UIImage] = []
    var delegate: HomeViewController?
    
    
    //서버로 보낼 데이터들.
    var itemTitle: String?
    var price: Int?
    var isSafePay = false
    var isTaekPo = false
    var category: [String] = []
    var tags: [String] = []
    var numOfItem: Int = 1
    var isOld: Bool = true
    var isExchangable: Bool = false
    var detail: String?
    
    @IBAction func goBackButtonTap(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func addItemButtonTap(_ sender: UIButton) {
        
        if let itemTitle = itemTitle, let price = price, let detail = detail {
           
            let item = ItemInfo(category: category, title: itemTitle, location: "부천시 송내2동", price: price, delivery_fee_included: isTaekPo, count: numOfItem, isOld: isOld, isExchangable: isExchangable, detail: detail, isSafe: isSafePay, tags: tags, images: [])
            
//            addManager.addItem(item: item)
            self.showIndicator()
            addManager.addItemWithImage(item: item, images: self.selectedImages)
            self.dismiss(animated: true) {
                self.delegate?.itemAdded()
            }
        } else {
            //MARK: 경고창 띄우기
            self.presentAlert(title: "필수  정보를 입력하세요", isCancelActionIncluded: true)
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //이미지
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    //제목
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleBarView: UIView!
    
    //카테고리
    @IBOutlet weak var categoryLabel: UILabel!
    @IBAction func categoryButtonTap(_ sender: UIButton) {
    }
    
    //태그
    @IBOutlet weak var tagCollectionViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBAction func tagButtonTap(_ sender: UIButton) {
    }
    
    //배송비 포함
    @IBOutlet weak var taekPoBackgroundView: UIView!
    @IBOutlet weak var taekPoImageView: UIImageView!
    @IBAction func taekPoButtonTap(_ sender: UITapGestureRecognizer) {
        if isTaekPo {
            taekPoImageView.tintColor = .systemGray6
            taekPoBackgroundView.layer.borderColor = UIColor.systemGray6.cgColor
            taekPoBackgroundView.backgroundColor = nil
            isTaekPo = false
        } else {
            taekPoImageView.tintColor = .white
            taekPoBackgroundView.layer.borderColor = UIColor(named: "badge")?.cgColor
            taekPoBackgroundView.backgroundColor = UIColor(named: "badge")
            isTaekPo = true
        }
    }
    
    //가격입력
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var wonImageView: UIImageView!
    @IBOutlet weak var priceBarView: UIView!
    //옵션 및 세부사항
    @IBAction func optionButtonTap(_ sender: UIButton) {
        
        presentReviewModalViewController()
    }
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    //하단 바 - 번개 페이, 등록 버튼
    @IBOutlet weak var safeButton: UIView!
    @IBOutlet weak var safeCheck: UIImageView!
    @IBOutlet weak var enrollButton: UIButton!
    
    //안전 결제 버튼 탭
    @IBAction func safeButtonTapped(_ sender: UITapGestureRecognizer) {
        if isSafePay {
            safeButton.layer.borderColor = UIColor.systemGray4.cgColor
            safeCheck.tintColor = UIColor.systemGray4
            isSafePay = false
        } else {
            safeButton.layer.borderColor = UIColor(named: "badge")?.cgColor
            safeCheck.tintColor = UIColor(named: "badge")
            isSafePay = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.navigationController?.navigationBar.isHidden = true
        
        if tags.isEmpty {
            // 비어 있다면 숨기기
            tagCollectionView.isHidden = true
        } else {
            
            // 비어있지 않다면 태그 컬렉션뷰 보이기
            tagCollectionView.isHidden = false
            tagCollectionView.backgroundColor = .systemBackground
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    //태그 컬렉션 뷰 동적 수정. 태그간 회색 파티션 추가
    override func viewDidAppear(_ animated: Bool) {
        
        
        tagCollectionView.reloadData()
        let height = tagCollectionView.contentSize.width
        if height > tagCollectionView.frame.width {
   
            tagCollectionViewTrailingConstraint.constant = 0
            tagCollectionView.backgroundColor = .systemGray6
        } else {
            if height > 60 {
                tagCollectionViewTrailingConstraint.constant = tagCollectionView.frame.width - height + 4
                tagCollectionView.backgroundColor = .systemGray6
            } else {
                tagCollectionViewTrailingConstraint.constant = 0
                tagCollectionView.backgroundColor = .systemBackground
            }
        }
    }
    
    //delegate 채택
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "category" {
            let vc = segue.destination as! CategoryViewController
            vc.delegate = self
        } else if segue.identifier == "tag" {
            let vc = segue.destination as! TagViewController
            vc.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.contentInset.left = -4
       
        addManager.delegate = self
        
        taekPoBackgroundView.layer.cornerRadius = taekPoBackgroundView.frame.height / 2
        taekPoBackgroundView.layer.borderWidth = 1
        taekPoBackgroundView.layer.borderColor = UIColor.systemGray4.cgColor
        
        
        
        //크래쉬 발생 임시 보류
        
        //키보드가 있는  상태에서 다른 키보드 열려고 하면 발생
        self.dismissKeyboardWhenTappedAround()
        
        safeButton.layer.masksToBounds = true
        safeButton.layer.cornerRadius = 5
        safeButton.layer.borderWidth = 1
        safeButton.layer.borderColor = UIColor.systemGray6.cgColor
        
        enrollButton.layer.masksToBounds = true
        enrollButton.layer.cornerRadius = 5
        
        //이미지 피커
        picker.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        
        //텍스트 뷰 플레이스 홀더 세팅
        placeholderSetting()
        
        //옵션 버튼 커스텀
        
        optionButton.layer.borderColor = UIColor.systemGray5.cgColor
        optionButton.layer.borderWidth = 1
        optionButton.layer.cornerRadius = 5
        optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self

        imageCollectionView.contentInset.left = 20
        titleTextField.delegate = self
        titleTextField.addDoneImageButtonOnKeyboard(message: "판매금지 품목 보기")
        priceTextField.delegate = self
        priceTextField.addDoneImageButtonOnKeyboard()
        detailTextView.delegate = self
    }
}


//MARK: - 태그 뷰 ~ 데이터 수신
extension AddViewController: TagDelegate {
    func tagViewDismissed(tags: [String]) {
        self.tags = tags
        tagCollectionView.reloadData()
    }
}


//MARK: - 카테고리 뷰 ~ 데이터 수신
extension AddViewController: CategoryDelegate {
    func categorySelected(cateogry: [String]) {
        self.category = cateogry
        
        if self.category.count > 1 {
            
            self.categoryLabel.textColor = .black
            let text = "\(cateogry.first!)  >  \(cateogry.last!)"
            let attributedStr = NSMutableAttributedString(string: text)
            let color = UIColor.lightGray
            attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: (text as NSString).range(of: ">"))
            
            categoryLabel.attributedText = attributedStr
        }
    }
    

}

//MARK: - 옵션 데이터 수신.
extension AddViewController: OptionDelegate {
    func optionChoosed(nuberOfItem: Int, isOld: Bool, isExchangable: Bool) {
        self.numOfItem = nuberOfItem
        self.isOld = isOld
        self.isExchangable = isExchangable
        
        
        
        optionLabel.text = "\(nuberOfItem)개•\(isOld ? "중고상품" : "새상품")• \(isExchangable ? "교환가능" : "교환불가")"
    }
}


//MARK: - 텍스트 필드 편집시 애니메이션
extension AddViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //해당 텍스트 필드 입력 시작시 하단 바 검정색으로 변경
        if textField == self.titleTextField {
            titleBarView.backgroundColor = .black
        } else {
            priceBarView.backgroundColor = .black
            wonImageView.tintColor = .black
        }
        
    }
    //텍스트 필드 입력 종료시 하단 바 회색으로 변경
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.titleTextField {
            titleBarView.backgroundColor = .lightGray
            itemTitle = textField.text
            
        } else {
            priceBarView.backgroundColor = .lightGray
            wonImageView.tintColor = .lightGray
            if let text = textField.text {
                price = Int(text)
                textField.text = textField.text?.insertComma
            }
        }
    }
}


//MARK: - 이미지 추가, 제거 버튼 클릭 시.
extension AddViewController: HeaderDelegate, DeleteDelegate {
    
    //삭제버튼 탭
    func deleteButtonTapped(index: Int) {
        selectedImages.remove(at: index)
        imageCollectionView.reloadData()
    }
    
    //추가버튼 탭
    func addButtonTapped() {
        self.openLibrary()
    }
    
    //이미지 피커 열기
    func openLibrary(){
      picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
      present(picker, animated: true, completion: nil)
    }
}


//MARK: - 이미지 피커 뷰 컨트롤러
extension AddViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        selectedImages.append(info[.originalImage] as! UIImage)
       
        picker.dismiss(animated: true, completion: {
            self.imageCollectionView.reloadData()
        })
    }
    
}



//MARK: - half modalView 띄우기
extension AddViewController: UIViewControllerTransitioningDelegate {
        // ...
    
    //half modal view 띄우는 메서드
    private func presentReviewModalViewController() {
            let storyboard = UIStoryboard(name: "AddStoryBoard", bundle: nil)
            guard let optionModalViewController = storyboard.instantiateViewController(withIdentifier: "OptionChoiceViewController") as? OptionChoiceViewController else {
                return
            }
            
            optionModalViewController.delegate = self

        
            optionModalViewController.modalPresentationStyle = .custom
            optionModalViewController.transitioningDelegate = self
            present(optionModalViewController, animated: true, completion: nil)
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let halfModalPC = HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
        halfModalPC.proportianoalYPosition = 0.44
        halfModalPC.proportionalHeight = 0.7
        
        return halfModalPC
    }
}


extension AddViewController: DismissDelegate {
    //다른 방법으로 로그인 시 호출 됨
    func dismiss() {
        print("option 선택 뷰 디스미스")
    }
}


extension AddViewController {
    func itemAdded() {
        self.dismissIndicator()
        self.navigationController?.popViewController(animated: true)
    }
    
    func failure(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: "등록 실패", message: message)
    }
}
