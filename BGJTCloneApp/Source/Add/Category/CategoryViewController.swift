//
//  CategoryViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/12.
//

import UIKit

protocol CategoryDelegate {
    func categorySelected(cateogry: [String])
}

    

class CategoryViewController: BaseViewController {
    
    
    var selectedCategory: [String]?
    
    var delegate: CategoryDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    let recentCategory: [String] = ["남성의류 > 티셔츠", "신발 > 스니커즈", "패션 액세서리 > 지갑", "디지털/가전 > 모바일", "스포츠/레저 > 인라인/스케이트보드"]
    let allCategory: [String] = ["여성의류", "남성의류", "신발", "가방" , "시계/쥬얼리", "패션 액세서리", "디지털/가전", "스포츠/레저"]
    
    let sections: [String] = ["최근 카테고리", "전체 카테고리"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}




extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            
            //문자열 파싱.
            let categoryString = recentCategory[indexPath.row]
            let category = categoryString.components(separatedBy: " > ")
        
            //델리게이트 함수로 전달
            delegate?.categorySelected(cateogry: category)
            
            //네비게이션 컨트롤러 디스미스
            _ = navigationController?.popViewController(animated: true)
            
            
        } else if indexPath.section == 1 {
          
        } else {
            return
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recentCategory.count
        } else if section == 1 {
            return allCategory.count
        } else {
            return 0
        }
    }
    
    //셀 이미지 할당.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTableViewCell", for: indexPath) as! RecentTableViewCell
            
            cell.categoryLabel.text = recentCategory[indexPath.row]
            
            
            return cell
            
        } else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
            
            cell.categoryLabel.text = allCategory[indexPath.row]
            cell.categoryImageView.image = UIImage(named: allCategory[indexPath.row].replacingOccurrences(of: "/", with: ":"))
            return cell
            
        } else {
           return UITableViewCell()
        }
    }
}
