//
//  NetworkService.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 14/09/21.
//

import UIKit

class NetworkService {
    
    static let sharedInstance = NetworkService()
    
    //MARK: GET
    /// This is the GET call through URL Session
    ///
    /// - Parameters:
    ///     - withBaseURL: the base url of the API call
    ///     - params: params to be passed in the call in form of dictionary
    ///     - completion: callback with AnyObject and Error Object
    func get(withBaseURL: String,
             params : [String : String]? = nil,
             completion: @escaping (_ result:AnyObject?,_ error:Error?) -> Void) {
        
        if var components = URLComponents(string: withBaseURL) {
            if let paramDict = params {
                let keys = paramDict.map{String($0.key) }
                for key in keys {
                    components.queryItems = [URLQueryItem(name: key, value: paramDict[key])]
                }
            }
            
            if let url2 = components.url {
                let request  = URLRequest(url: url2)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    DispatchQueue.main.async {
                        if error == nil {
                            if let responseData = data, let utf8Text = String(data: responseData, encoding: .utf8) {
                                do {
                                    if !utf8Text.isEmpty {
                                        if let j = try JSONSerialization.jsonObject(with: responseData, options: [.allowFragments]) as? [String: Any] {
                                            completion(j as AnyObject, nil)
                                        }
                                        else {
                                            completion(nil, error)
                                        }
                                    }
                                    else {
                                        completion(nil, error)
                                    }
                                } catch let error as NSError {
                                    completion(nil, error)
                                }
                                
                            } else {
                                completion(nil, error)
                            }
                        } else {
                            completion(nil, error)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
}
