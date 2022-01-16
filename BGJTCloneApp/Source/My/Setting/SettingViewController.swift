//
//  SettingViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import UIKit

class SettingViewController: BaseViewController {
    
    
    
    let userSettings: [String] = ["계정 설정" , "알림 설정", "우리동네 지역 설정", "배송지 설정", "계좌 설정", "간편결제 카드설정", "차단 상점 관리"]
    let serviceInfos: [String] = ["이용약관","개인정보 처리방침", "위치기반 서비스 이용약관", "버전정보 8.5.0"]
    
    let logout: [String] = ["로그아웃"]
    
    let sections: [String] = ["사용자 설정", "서비스 정보", " "]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.navigationBar.topItem?.title = "설정"
    }
}



extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            if indexPath.row == 4{
                // 계좌 설정뷰로 이동
                let vc = UIStoryboard(name: "AccountStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        } else if indexPath.section == 1 {
          
        } else {
            return
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return userSettings.count
        } else if section == 1 {
            return serviceInfos.count
        } else {
            return 1
        }
    }
    
    //셀 이미지 할당.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        if indexPath.section == 0 {
            cell.titleLabel.text = userSettings[indexPath.row]

        } else if indexPath.section == 1{
            cell.titleLabel.text = serviceInfos[indexPath.row]
            return cell
        } else {
            cell.titleLabel.text = "로그아웃"
        }
        return cell
    }
}
