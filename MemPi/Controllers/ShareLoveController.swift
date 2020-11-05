//
//  ShareLoveController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 5.11.2020.
//

import Foundation
import UIKit
import MessageUI
class ShareLoveController:CustomViewController{
    
    //MARK: - Properties
    
    lazy var shareLoveView = ShareLoveView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    //MARK: - Helpers
    
    private func addTargets(){
        shareLoveView.rateUsButton.addTarget(self, action: #selector(rateUsClicked), for: .touchUpInside)
        shareLoveView.supportButton.addTarget(self, action: #selector(supportClicked), for: .touchUpInside)
    }
    
    private func configureUI(){
        view.addSubview(shareLoveView)
        shareLoveView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    //MARK: - Selectors
    
    @objc private func rateUsClicked(){
        getRating()
    }
    
    @objc private func supportClicked(){
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["support@batuhankarababa.com"])
            mail.setMessageBody("<p>Hello! </p>", isHTML: true)
            mail.setSubject("I have a feedback")
            present(mail, animated: true)
        }
    }
    
}

extension ShareLoveController:MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        if error != nil{
            showAlert(title: "Oops", message: "Your feedback couldn't reach us 🥺 Please try again in a few minutes.")
        }else{
            showAlert(title: "Thanks!", message: "Your feedback reached us! We will review it within 24 hours 🥰")
        }
    }
}
