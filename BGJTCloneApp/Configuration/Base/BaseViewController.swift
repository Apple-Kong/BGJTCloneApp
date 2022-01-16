//
//  BaseViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit


//모든 뷰 컨트롤러 마다 공통적으로 들어가는 사항을 포함시키면 된다.
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 아래 예시들처럼 상황에 맞게 활용하시면 됩니다. 네비게이션 바 글꼴이나 이런것들.
//
//    //     Navigation Bar
//        self.navigationController?.navigationBar.titleTextAttributes = [
//            .font : UIFont.NotoSans(.medium, size: 16),
//        ]
        
        //틴트컬러 검정
        self.navigationController?.navigationBar.tintColor = .black
        //백버튼 제목 삭제
        self.navigationController?.navigationBar.topItem?.title = ""
        //assign button to navigationbar
        
        
        
         //Background Color
      
        
    }
}
