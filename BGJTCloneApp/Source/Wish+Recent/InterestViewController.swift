//
//  InterestViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import UIKit
import Tabman
import Pageboy






class InterestViewController: TabmanViewController {
    
    private var viewControllers: Array<UIViewController> = []
    //This method will call when you press button.
    @objc func fbButtonPressed() {

        print("Share to fb")
    }
    
    @IBOutlet weak var customTabView: UIView!
    
    @IBAction func backButtonTap(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
   
    override func viewDidLoad() {
       super.viewDidLoad()
        
        
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 16, weight: .bold),
        ]
        
//        self.navigationItem.title = "관심상품"

        let buttonStrings = ["edit", "filter", "plus"]
        var buttons: [UIBarButtonItem] = []
        for string in buttonStrings {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
            //set image for button
            button.setImage(UIImage(named: string)?.resizeImage(size: CGSize(width: 24, height: 24)), for: .normal)
            //add function for button
            button.addTarget(self, action: #selector(fbButtonPressed), for: .touchUpInside)
            //set frame
            buttons.append(UIBarButtonItem(customView: button))
        }
        self.navigationItem.rightBarButtonItems = buttons
        //assign button to navigationbar
        
      
//        /*** If needed Assign Title Here ***/
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "no", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        self.navigationItem.title = "관심 상품"
        
//        self.navigationItem.titleView?.frame = CGRect(x: -30, y: 0, width: 50, height: 50)
       
       //MARK: - 커스텀 탭바 추가.
       let vc2 = UIStoryboard.init(name: "InterestStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "WishCollctionViewController") as! WishCollctionViewController
        
        
       let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BrandViewController") as! BrandViewController
        
    
        
       viewControllers.append(vc2)
       viewControllers.append(vc3)
       
       self.dataSource = self

       // Create bar
       let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        
       settingTabBar(ctBar: bar) //함수 추후 구현
       // Add to view
        addBar(bar, dataSource: self, at: .custom(view: customTabView, layout: nil))
   }
}







extension InterestViewController {
    func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .snap
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0, bottom: 0.0, right: 0)
        
        // 간격
        ctBar.layout.interButtonSpacing = 20
        // background 스타일
        ctBar.backgroundView.style = .flat(color: .white)
        
        // 선택 / 안선택 색 + font size
        ctBar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            button.selectedFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        }
        
        // 인디케이터
        ctBar.indicator.weight = .custom(value: 2)
        ctBar.indicator.tintColor = .black
  
    }
}



extension InterestViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    //bar item 별 설정.
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = "Page \(index)"
        
        switch index {
        case 0:
            return TMBarItem(title: "찜")
        case 1:
            let item = TMBarItem(title: "최근 본 상품")
            
            return item
        default:
            return TMBarItem(title: "page \(index)")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
