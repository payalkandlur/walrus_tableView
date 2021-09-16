//
//  FetchNewsStore.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 14/09/21.
//

import UIKit

class FetchNewsStore {
    
    static let sharedInstance = FetchNewsStore()
    
    /// This function fetches the news data fom the url.
    ///
    /// - Parameter urlString: `String` is URL to get news data
    func getNewsData(urlString: String, callback:@escaping (_ result: [ArticleModel]?,_ error:Error?) -> Void) {
        NetworkService.sharedInstance.get(withBaseURL: urlString) {
            (result, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let resultData = result as? [String: Any] {
                    if let res = resultData["articles"] {
                        if let data = try? JSONSerialization.data(withJSONObject: res, options: .prettyPrinted) {
                            let decodedData = try? decoder.decode([ArticleModel].self, from: data)
                            callback(decodedData, nil)
                        } else {
                            callback(nil, error)//"ZERO_RESULTS"
                        }
                    } else {
                        callback(nil, error)
                    }
                } else {
                    callback(nil, error)
                }
            }
            else {
                callback(nil, error)
            }
        }
    }
    
}
