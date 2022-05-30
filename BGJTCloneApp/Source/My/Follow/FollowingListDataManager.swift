//
//  FollowListDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import Foundation
import Alamofire

protocol FollowingListDelegate {
    func didfetched(data: [FollowingResult])
    func failure(message: String)
}

protocol FollowerListDelegate {
    func didFetched(data: [FollowerInfo])
    func failure(message: String)
}

class FollowingListDataManager {
    
    var followingDelegate: FollowingListDelegate?
    var followerDelegate: FollowerListDelegate?
    func fetchFollowingList() {
        
        print("-----상점 팔로잉 리스트 요청 시작 -----")
        let url = Constant.MAIN_URL + "/api/follow/users/following"
        
        AF.request(url, method: .get, headers: Secret.tokenHeaders)
            .responseDecodable(of: FollowingListResponse.self) { response in
                switch response.result {
                case .success:
                    self.followingDelegate?.didfetched(data: response.value!.result)
                    print(response.value!)
                case .failure(let error):
                    self.followingDelegate?.failure(message: error.localizedDescription)
                }
            }
    }
    
    func fetchFollowerList() {
        print("-----상점 팔로워 리스트 요청 시작 -----")
        let url = Constant.MAIN_URL + "/api/follow/users/follower"
        
        AF.request(url, method: .get, headers: Secret.tokenHeaders)
            .responseDecodable(of: FollowerListResponse.self) { response in
                switch response.result {
                case .success:
                    self.followerDelegate?.didFetched(data: (response.value?.result.followerInfo)!)
                case .failure(let error):
                    self.followerDelegate?.failure(message: error.localizedDescription)
                }
            }
    }
}
