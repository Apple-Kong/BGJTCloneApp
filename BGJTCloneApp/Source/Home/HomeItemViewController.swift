//
//  HomeItemViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import UIKit
import Tabman
import Pageboy

class HomeItemViewController: TabmanViewController {
    
    
    private var viewControllers: Array<UIViewController> = []
   

   override func viewDidLoad() {
       super.viewDidLoad()

       let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecommendViewController") as! RecommendViewController
       let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BrandViewController") as! BrandViewController
           
       viewControllers.append(vc2)
       viewControllers.append(vc3)
       
       self.dataSource = self

       // Create bar
       let bar = TMBar.ButtonBar()
       bar.layout.transitionStyle = .snap // Customize
       settingTabBar(ctBar: bar) //함수 추후 구현
       // Add to view
       addBar(bar, dataSource: self, at: .top)
   }
    
    
    func settingTabBar (ctBar : TMBar.ButtonBar) {
            ctBar.layout.transitionStyle = .snap
            // 왼쪽 여백주기
            ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
            
            // 간격
            ctBar.layout.interButtonSpacing = 20
                
            ctBar.backgroundView.style = .flat(color: .white)
            
            // 선택 / 안선택 색 + font size
            ctBar.buttons.customize { (button) in
                button.tintColor = .gray
                button.selectedTintColor = .black
                button.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
                button.selectedFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
            }
            
            // 인디케이터 (영상에서 주황색 아래 바 부분)
            ctBar.indicator.weight = .custom(value: 3)
            ctBar.indicator.tintColor = .black
      
        }
}

extension HomeItemViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = "Page \(index)"
        
        switch index {
        case 0:
            return TMBarItem(title: "추천 상품")
        case 1:
            let item = TMBarItem(title: "브랜드")
            item.badgeValue = " "
            
            return item
        default:
            return TMBarItem(title: "page \(index)")
        }
        
        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
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
