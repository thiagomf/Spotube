//
//  ViewController.swift
//  Spotube
//
//  Created by Thiago Machado Faria on 07/06/2019.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Hello world")
    }

    
    @IBAction func connectSpot(_ sender: Any) {
        
        let requestedScopes: SPTScope = [.appRemoteControl, .playlistReadPrivate]
        AppDelegate().sessionManager.initiateSession(with: requestedScopes, options: .default)
    }
    
}

