//
//  ViewController.swift
//  GPSDemo
//
//  Created by will on 2021/12/29.
//

import UIKit
//加入定位功能
import CoreLocation

class ViewController: UIViewController {
    
    var locationMannger = LocationMannger.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //每次畫面出現後呼叫gps定位
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LocationMannger.shared.askPermission()
    }
    
    ///alert 通知
    func alertMessage(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func open(_ sender: Any) {
        
    }
}


