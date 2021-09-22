//
//  ViewController.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 14/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array = [ArticleModel]()
    var newArr: [Any] = Array()
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ViewArticlesViewModel()
    
    var urlVal  = URL(string: "https://www.apple.com")
    var titleVal: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register custom table view cell
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "HeaderViewCell", bundle: nil), forCellReuseIdentifier: "HeaderViewCell")

        //Fetch data from the API if Realm is empty
        self.array = RealmManager.sharedManager.fetchObjects() ?? []
        if(self.array.isEmpty) {
            viewModel.getArticles(urlString: "https://newsapi.org/v2/top-headlines?country=us&apiKey=3e6b52f54a304686904efad1b7e126b9")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        self.hideNavBar()
        self.registerViewModelListeners()
        //show activity indicator before fetching data
        self.overlayView.isHidden = true
        tableView.separatorStyle = .none
        
    }
    
    func hideNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Register View Model
    func registerViewModelListeners() {
        viewModel.isFetchArticlesSuccess.bind { [self] success in
            if success {
                //hide activity indicator after fetching is success
                CommonUtils.sharedInstance.hideActivityIndicator()
                self.array = viewModel.array ?? []
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
                
            } else {
                self.overlayView.isHidden = true
                self.array = RealmManager.sharedManager.fetchObjects() ?? []
                self.tableView.reloadData()
                print("Error")
            }
        }
    }
    
    
    // MARK: - TablView Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return self.array.count
        }
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderViewCell") as? HeaderViewCell {
                
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CardTableViewCell
            
            cell.authorLabel.text = array[indexPath.row].author
            cell.titleLabel.text = array[indexPath.row].title
            
            cell.descLabel.text = array[indexPath.row].articleDescription
            self.urlVal = URL(string: (array[indexPath.row].url) ?? "")
            self.titleVal = array[indexPath.row].title
                let url = URL(string: (self.array[indexPath.row].urlToImage) ?? "")
                if let urls = url {
                    let data = try? Data(contentsOf: urls)
                    DispatchQueue.main.async {
                    if let img = data {
                        cell.imgView?.image = UIImage(data: img)
                    }
                    
                }
            }
            
            
            //set button action
            cell.setSeeNewsActionType {
                self.showWebView(URL(string: (self.array[indexPath.row].url) ?? ""), self.array[indexPath.row].title)
            }
            return cell
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    // MARK: - WebView display function
    ///This function presents the WKWebKit to display the url in web view.
    func showWebView(_ urlString: URL?, _ title: String?) {
        let vc = self.storyboard?.instantiateViewController(identifier: "WebViewViewController") as! WebViewViewController
        vc.url = urlString
        vc.titleVal = title
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

