//
//  RealmManager.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 14/09/21.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    
    static let sharedManager = RealmManager()
    
    var realmURL: String!
    
    
    func addObjects(object: [Object], completion:@escaping (_ done:Bool ) -> Void) {
        let realm = try! Realm()
        do {
            
            try realm.write {
                
                realm.add(object)
                realm.refresh()
            
            }
            
            completion(true)
            
            
        } catch (let error as NSError) {
            
            print("ERROR: Realm: writing to database, ERROR: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func fetchObjects() -> [ArticleModel]? {
        let realm = try! Realm()
        var arr : [ArticleModel] = []
        let articles = realm.objects(ArticleModel.self)
        for i in articles {
            arr.append(i)
        }
        print(articles)
        return arr
    }
    
}
