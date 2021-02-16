//
//  ViewController.swift
//  Spotube
//
//  Created by Thiago Machado Faria on 07/06/2019.
//  Copyright © 2019 Thiago Machado Faria. All rights reserved.
//

import UIKit
import JGProgressHUD
import GoogleAPIClientForREST
import GoogleSignIn

protocol SpotifyLoginDisplayLogic: class {
    
    var interactor: SpotifyLoginBusinessLogic? { get set }
    
    var wireFrame: SpotifyLoginWireframeProtocol? { get set }
    
    func displayFetchedUser(viewModel: Login.FetchUser.ViewModel?)
}

class SpotifyLoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    var interactor: SpotifyLoginBusinessLogic?
    
    var wireFrame: SpotifyLoginWireframeProtocol?
    
    let hud = JGProgressHUD(style: .light)
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeYouTubeReadonly]
    
    private let service = GTLRYouTubeService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = "Carregando"
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        
        // Add the sign-in button.
        view.addSubview(signInButton)
        
        // Add a UITextView to display output.
        output.frame = view.bounds
        output.isEditable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        output.isHidden = true
        view.addSubview(output)
    }
    
    @IBAction func connectSpot(_ sender: Any) {
        hud.show(in: self.view)
        interactor?.loginSpotify()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            print("Token: \(user.authentication.fetcherAuthorizer())")
            fetchChannelResource()
        }
    }
    
    // List up to 10 files in Drive
    func fetchChannelResource() {
        let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "snippet,statistics")
        query.mine = true
        // To retrieve data for the current user's channel, comment out the previous
        // line (query.identifier ...) and uncomment the next line (query.mine ...)
        // query.mine = true
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
    }
    
    // Process the response and display output
    @objc
    func displayResultWithTicket(ticket: GTLRServiceTicket,
                                 finishedWithObject response : GTLRYouTube_ChannelListResponse,
                                 error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var outputText = ""
        if let channels = response.items, !channels.isEmpty {
            let channel = response.items![0]
            let title = channel.snippet!.title
            let description = channel.snippet?.descriptionProperty
            let viewCount = channel.statistics?.viewCount
            outputText += "title: \(title!)\n"
            outputText += "description: \(description!)\n"
            outputText += "view count: \(viewCount!)\n"
        }
        output.text = outputText
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}

extension SpotifyLoginViewController: SpotifyLoginDisplayLogic {
    
    func displayFetchedUser(viewModel: Login.FetchUser.ViewModel?) {
        
        hud.dismiss()
        
        if let user = viewModel {
            print("Name: \(String(describing: user.displayedUser.displayName))")
            wireFrame?.routerGoUserPLaylist(user: user.displayedUser)
        }
        
    }
}

