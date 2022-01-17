//
//  FollowingViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import UIKit
import Alamofire


class FollowingViewController: UIViewController {
    
    let followListDataManager = FollowListDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
}


extension FollowingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

class FollowListDataManager {
    func fetchFollowingList() {
        print("-----상점 팔로잉 리스트 요청 시작 -----")
        let url = Constant.MAIN_URL + "/api/follow/users/following"
        
        AF.request(url, method: .get, headers: Secret.tokenHeaders)
            .responseString { response in
                print(response.value)
            }
            .responseDecodable(of: FollowingListResponse.self) { response in
                switch response.result {
                case .success:
                    print("상점 팔로우 목록 : \(response.value)")
                case .failure(let error):
                    print("상점 팔로우 목록 실패 : \(error.localizedDescription)")
                }
            }
            
        
    }
    
    func fetchFollowerList() {
        print("-----상점 팔로워 리스트 요청 시작 -----")
        let url = Constant.MAIN_URL + "/api/follow/users/following"
        
        AF.request(url, method: .get, headers: Secret.tokenHeaders)
            .responseString { response in
                print(response.value)
            }
            .responseDecodable(of: FollowerListResponse.self) { response in
                switch response.result {
                case .success:
                    print("상점 팔로우 목록 : \(response.value)")
                case .failure(let error):
                    print("상점 팔로우 목록 실패 : \(error.localizedDescription)")
                }
            }
    }
}

struct FollowerListResponse: Decodable {
    
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FollowerResult]
    
    struct FollowerResult: Decodable {
        let userId: Int
        let shopName: String
        let getItemResult: [ItemResult]
        
        struct ItemResult: Decodable {
            let item_id: Int
            let price: Int
            let image_path: String
        }
    }
}

struct FollowingListResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FollowResult]
    
    struct FollowResult: Decodable {
        let item_id: Int
        let image_path: String
        let safety_pay: Int
        let title: String
        let price: Int
        let created_at: String
        let shop_name: String
    }
}
