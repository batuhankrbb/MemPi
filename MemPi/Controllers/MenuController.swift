//
//  MenuController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import StoreKit

final class MenuController: CustomViewController {
    
    //MARK: - Properties
    private lazy var menuView = MenuView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        
        UserDefaultsService.shared.updateReviewCount { (showReview) in
            if showReview{
                getRating()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        menuView.coinShow.number = UserDefaultsService.shared.getCoin()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = ct_Color.softPink
    }
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = ct_Color.pink
        view.addSubview(menuView)
        menuView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = ct_Color.softPink
        navigationController?.navigationBar.tintColor = ct_Color.purple
        
    }
    
    private func addTargets(){
        menuView.trainingButton.addTarget(self, action: #selector(trainingClicked), for: .touchUpInside)
        menuView.challangeButton.addTarget(self, action: #selector(challangeClicked), for: .touchUpInside)
        menuView.digitsButton.addTarget(self, action: #selector(digitsClicked), for: .touchUpInside)
        menuView.soundSwitch.addTarget(self, action: #selector(soundValueChanged), for: .valueChanged)
    }
    
    //MARK: - Selectors
    @objc private func trainingClicked(){
        SoundService.shared.playSound(sound: .menuButtonClick)
        let trainingStartController = TrainingStartController()
        navigationController?.pushViewController(trainingStartController, animated: true)
    }
    
    @objc private func challangeClicked(){
        SoundService.shared.playSound(sound: .menuButtonClick)
        let challangeStartController = ChallangeStartController()
        navigationController?.pushViewController(challangeStartController, animated: true)
    }
    
    @objc private func digitsClicked(){
        SoundService.shared.playSound(sound: .menuButtonClick)
        let allDigitsController = AllDigitsController()
        navigationController?.pushViewController(allDigitsController, animated: true)
    }
    
    @objc private func soundValueChanged(sender:UISwitch){
        SoundService.shared.playSound(sound: .menuButtonClick)
        SoundService.shared.isSoundOn = sender.isOn
    }
}
