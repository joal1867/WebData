//
//  ViewController.swift
//  AlamofireTest
//
//  Created by Joal on 20/11/2018.
//  Copyright © 2018 Joal. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = Alamofire.request("https://www.daum.net", method:.get)
        request.response{
            response in
            let msg = NSString(data:response.data!,
                               encoding:String.Encoding.utf8.rawValue)
            print(msg!)
            
        }


    }

}
