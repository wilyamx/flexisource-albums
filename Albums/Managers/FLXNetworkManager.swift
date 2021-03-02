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
    
    static let BASE_URL = "https://api-metadata-connect.tunedglobal.com/api/v2.1"
    static let PAGE_SIZE = 10
    
    let STORE_ID: String = "luJdnSN3muj1Wf1Q"
    
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
     {
         "Offset": 1,
         "Count": 1,
         "Total": 50,
         "Results": [
             {
                 "AlbumId": 65287051,
                 "Name": "Biber/Schmelzer: Trumpet Music",
                 "Upc": null,
                 "Artists": [
                     {
                         "ArtistId": 157316,
                         "Name": "Philip Pickett"
                     }
                 ],
                 "AlbumType": "Album",
                 "PrimaryRelease": {
                     "ReleaseId": 65287051,
                     "AlbumId": 65287051,
                     "Artists": [
                         {
                             "ArtistId": 157316,
                             "Name": "Philip Pickett"
                         }
                     ],
                     "Name": "Biber/Schmelzer: Trumpet Music",
                     "OriginalCredit": null,
                     "IsExplicit": false,
                     "NumberOfVolumes": 1,
                     "TrackIds": [
                         65893363
                     ],
                     "Duration": 3961,
                     "Volumes": [
                         {
                             "FirstTrackIndex": 0,
                             "LastTrackIndex": 11
                         }
                     ],
                     "Image": "https://tunedglobal-a.akamaihd.net/images1004/100/4_0/002/894/258/342/9/104_1004_00028942583429_0_20180831_0402.jpg",
                     "WebPath": null,
                     "Copyright": null,
                     "Label": {
                         "LabelId": "3977",
                         "Name": "Decca Music Group Ltd."
                     },
                     "ReleaseDate": "2008-04-07T00:00:00Z",
                     "OriginalReleaseDate": "2008-04-07T00:00:00Z",
                     "PhysicalReleaseDate": null,
                     "DigitalReleaseDate": null,
                     "SaleAvailabilityDateTime": "0001-01-01T00:00:00Z",
                     "StreamAvailabilityDateTime": "0001-01-01T00:00:00Z",
                     "AllowDownload": true,
                     "AllowStream": true,
                     "ContentLanguage": null
                 },
                 "PrimaryReleaseId": 65287051,
                 "ReleaseIds": [
                     65287051
                 ]
             }
         ]
     }
     */
    public func getAlbums(
        offset: Int,
        completion: @escaping ([FLXAlbumCodable]?) -> ()) {

        let url2 = URL(string: "\(FLXNetworkManager.BASE_URL)/albums/trending?offset=\(offset)&count=\(FLXNetworkManager.PAGE_SIZE)")

        guard let url = url2  else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        request.setValue(STORE_ID, forHTTPHeaderField:"StoreId")
        
        URLSession.shared.dataTask(
            with: request,
            completionHandler: {
                data, response, error -> Void in
                    if let data = data {
                        do {
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(FLXResponseCodable.self, from: data)
                            DebugInfoKey.api.log(info: "\(responseModel.results?.count)")
                            completion(responseModel.results)
                        }
                        catch let error {
                            DebugInfoKey.error.log(info: "JSON Serialization error :: \(error)")
                        }
                    }
            }).resume()

    }
}
