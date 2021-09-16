//
//  AnimationViewController.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 16/09/21.
//

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var nextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstAnimation()
        // Do any additional setup after loading the view.
        
        self.nextLabel.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.squareView.layer.cornerRadius = 5
    }
    
    func firstAnimation() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        squareView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        UIView.animate(withDuration: 1, animations: {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            self.squareView.frame = CGRect(x: (keyWindow?.screen.bounds.midX ?? 0) - 30, y: self.squareView.frame.origin.y, width: self.squareView.frame.width, height: self.squareView.frame.height)
            self.squareView.transform = CGAffineTransform(scaleX: 2, y: 2)
            
            self.squareView.backgroundColor = UIColor.init(hex: "#19BDA9")
            self.nextLabel.isHidden = true
        })
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
        squareView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap2(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 1.5, animations: {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            
            self.squareView.transform = CGAffineTransform(scaleX: keyWindow?.screen.bounds.width ?? 0, y: keyWindow?.screen.bounds.height ?? 0)
            
            self.squareView.backgroundColor = UIColor.init(hex: "535655")
            
            self.nextLabel.isHidden = false
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.nextButtonTapped(_:)))
            self.nextLabel.isUserInteractionEnabled = true
            self.nextLabel.addGestureRecognizer(tap)
            
        })
    }
    
    @objc func nextButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
