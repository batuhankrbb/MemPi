//
//  ChallangeController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds

final class ChallangeController: CustomViewController {
    
    //MARK: - Properties
    private lazy var challangeView = GuessChallangeView()
    
    private var presentedNumbers = [PiCollectionNumber]()
    
    private var reuseNumberCell = "NumberCell"
    
    private var reuseWrongNumberCell = "WrongNumberCell"
    
    private var rewardedAdService = RewardedAdService(advertisementID: ct_Ads.rewarded_guessChallangeNotEnough)
    
    var guessService:GuessService!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        presentedNumbers = guessService.numbersSoFar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        challangeView.piNumberCollectionView.scrollToItem(at: IndexPath(item: presentedNumbers.count - 1, section: 0), at: [.centeredHorizontally], animated: true)
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        view.backgroundColor = ct_Color.pink
        view.addSubview(challangeView)
        challangeView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        challangeView.digit = guessService.currentDigit
    }
    
    private func addTargets(){
        challangeView.numberList.forEach { (button) in
            button.addTarget(self, action: #selector(numberClicked), for: .touchUpInside)
        }
        challangeView.answerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(answerClicked)))
        challangeView.hintView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hintClicked)))
    }
    
    private func configureCollectionView(){
        challangeView.piNumberCollectionView.register(NumberCell.self, forCellWithReuseIdentifier: reuseNumberCell)
        challangeView.piNumberCollectionView.register(WrongNumberCell.self, forCellWithReuseIdentifier: reuseWrongNumberCell)
        challangeView.piNumberCollectionView.delegate = self
        challangeView.piNumberCollectionView.dataSource = self
        challangeView.piNumberCollectionView.alwaysBounceHorizontal = true
        
    }
    
    private func appendAndAdjustNumber(challangeNum:PiCollectionNumber){
        presentedNumbers.append(challangeNum)
        challangeView.digit = guessService.currentDigit
        challangeView.piNumberCollectionView.reloadData()
        challangeView.piNumberCollectionView.scrollToItem(at: IndexPath(item: presentedNumbers.count - 1, section: 0), at: [.centeredHorizontally], animated: true)
    }
    
    private func presentOverController(){
        let overController = ChallangeOverController()
        UserDefaultsService.shared.setBestScore(score: guessService.knownNumbers)
        let bestScore = UserDefaultsService.shared.getBestScore()
        let overModel = OverModel(best: bestScore, rememberedNumber: guessService.knownNumbers, earned: guessService.knownNumbers / 4)
        
        overController.overModel = overModel
        navigationController?.pushViewController(overController, animated: false)
    }
    
    //MARK: - Selectors
    
    @objc private func answerClicked(){
        UserDefaultsService.shared.decreaseCoin(coinToDecrease: 20) { (error) in
            if let error = error{
                showNoCoinAlert(error: error, adService: rewardedAdService, delegate: self)
            }
            else{
                challangeView.makeGuided(buttonNum: guessService.answer)
            }
        }
    }
    
    @objc private func hintClicked(){
        UserDefaultsService.shared.decreaseCoin(coinToDecrease: 10) { (error) in
            if let error = error{
                showNoCoinAlert(error: error, adService: rewardedAdService, delegate: self)
            }else{
                showAlert(title: "Here is the hint :) 💡", message: guessService.hint)
            }
        }
    }
    
    @objc private func numberClicked(button:NumberButton){
        if guessService.isFinished{
            showCompleteAlert()
        }
        if challangeView.isGuided{
            challangeView.removeGuide()
        }
        SoundService.shared.playSound(sound: .buttonClick)
        guessService.guessNext(number: button.number, digit: guessService.currentDigit) { (cases) in
            switch cases{
            case .correct:
                appendAndAdjustNumber(challangeNum: PiCollectionNumber(number: "\(button.number!)"))
            case .died(let correctNum):
                challangeView.heartImageView.image = ct_Image.hearts0
                appendAndAdjustNumber(challangeNum: PiCollectionNumber(number: "\(correctNum)",isCorrect: false))
                presentOverController()
            case let .wrong(healthImage,correctNum):
                appendAndAdjustNumber(challangeNum: PiCollectionNumber(number: "\(correctNum)",isCorrect: false))
                challangeView.heartImageView.image = healthImage
            }
        }
    }
    
}

extension ChallangeController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presentedNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let challNum = presentedNumbers[indexPath.row]
        if challNum.isCorrect{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseNumberCell, for: indexPath) as? NumberCell{
                cell.challangeNumber = challNum
                return cell
            }
        }else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseWrongNumberCell, for: indexPath) as? WrongNumberCell{
                cell.challangeNumber = challNum
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    
}

extension ChallangeController:GADRewardedAdDelegate{
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        rewardedAdService.reloadRewardedAd()
        rewardedAdService.rewardedAdIsWatched {(_) in}
    }
}
