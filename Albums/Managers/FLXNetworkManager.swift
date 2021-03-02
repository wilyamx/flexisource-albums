//
//  FLXNetworkManager.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//

import Foundation
import SystemConfiguration

struct FLXRequestError {
    var errorCode: Int = 0
    var errorMessage: String = ""
}

enum FLXResponse<T> {
    case succeed(T)
    case failed(FLXRequestError)
}

class FLXNetworkManager {
    static let shared = FLXNetworkManager()
    
    static let BASE_URL = "https://api.github.com"
    static let PAGE_SIZE = 5
    
    // MARK: - Monitoring
    
    // https://stackoverflow.com/questions/25398664/check-for-internet-connection-availability-in-swift
    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        if flags.isEmpty {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }

    // MARK: - GitHub APIs
    
    /*
     [
       {
         "login": "octocat",
         "id": 1,
         "node_id": "MDQ6VXNlcjE=",
         "avatar_url": "https://github.com/images/error/octocat_happy.gif",
         "gravatar_id": "",
         "url": "https://api.github.com/users/octocat",
         "html_url": "https://github.com/octocat",
         "followers_url": "https://api.github.com/users/octocat/followers",
         "following_url": "https://api.github.com/users/octocat/following{/other_user}",
         "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
         "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
         "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
         "organizations_url": "https://api.github.com/users/octocat/orgs",
         "repos_url": "https://api.github.com/users/octocat/repos",
         "events_url": "https://api.github.com/users/octocat/events{/privacy}",
         "received_events_url": "https://api.github.com/users/octocat/received_events",
         "type": "User",
         "site_admin": false
       }
     ]
     */
//    public func getUsers(
//        lastUserId: Int32,
//        completion: @escaping ([TWKGithubUserCodable]?) -> ()) {
//
//        guard let url = URL(string: "\(TWKNetworkManager.BASE_URL)/users?since=\(lastUserId)&per_page=\(TWKNetworkManager.PAGE_SIZE)") else {
//            return
//        }
//
//        URLSession.shared.dataTask(
//            with: url,
//            completionHandler: {
//                data, response, error -> Void in
//                    if let data = data {
//                        do {
//                            let jsonDecoder = JSONDecoder()
//                            let responseModel = try jsonDecoder.decode([TWKGithubUserCodable].self, from: data)
//                            DebugInfoKey.api.log(info: "\(responseModel)")
//                            completion(responseModel)
//                        }
//                        catch let error {
//                            DebugInfoKey.error.log(info: "JSON Serialization error :: \(error)")
//                        }
//                    }
//            }).resume()
//
//    }
}
