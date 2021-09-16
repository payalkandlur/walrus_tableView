//
//  FetchNewsManager.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 14/09/21.
//

import UIKit
import Realm
import RealmSwift

class FetchNewsManager {
    
    var alertMessage : String! = ""
    var bootstrapLoaded = false
    var isGetBootstrapInfoSuccess: Dynamic<Bool> = Dynamic(false)
    var errorMessage = ""
    
    static let sharedInstance = FetchNewsManager()
    
    /// This function fetches the news data fom the url.
    ///
    /// - Parameter urlString: `String` is URL to get news data
    func loadNewsData(urlString: String,_ callback:@escaping ( _ response:[ArticleModel]?, _ error:Error?) -> Void) {
        FetchNewsStore.sharedInstance.getNewsData(urlString: urlString) {
            (model, error) in
            if error == nil {
                RealmManager.sharedManager.addObjects(object: model!) {
                    done in
                    if done {
                        callback(model, nil)
                    } else {
                        callback(nil, error)
                    }
                }
                callback(model,nil)
            } else {
                callback(nil, error)
            }
        }
    }
    
}
