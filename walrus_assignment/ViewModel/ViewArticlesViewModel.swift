//
//  ViewArticles.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 14/09/21.
//

import UIKit

class ViewArticlesViewModel {

        static let sharedInstance = ViewArticlesViewModel()
        var isFetchArticlesSuccess: Dynamic<Bool> = Dynamic(false)
        var errorMessage = ""
        var array : [ArticleModel]?
        //MARK: Load the articles
        /// This function will get the bootstrap data from Bootstrap Manager.
        ///
        /// It will set the reponse to bootstrapInfo and updateType if we have a proper
        /// response else will set the error.
        ///
    func getArticles(urlString: String) {
            FetchNewsManager.sharedInstance.loadNewsData(urlString: urlString) {
                (response, error) in
                if response != nil {
                    self.array = response
                    self.isFetchArticlesSuccess.value = true
                } else {
                    self.errorMessage = error.debugDescription
                    self.isFetchArticlesSuccess.value = false
                }
            }
        }
    
//    func getFromRealm() {
//        RealmManager.sharedManager.fetchObjects(object: <#T##Object.Type#>) {
//            
//        }
//    }
}

