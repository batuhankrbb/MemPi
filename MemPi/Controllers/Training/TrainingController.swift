//
//  TrainingController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds

class TrainingController: CustomViewController, GADBannerViewDelegate {
    
    //MARK: - Properties
    private lazy var trainingView = TrainingView()
    
    
    var trainingService:TrainingService!
    
    private var presentedNumbers = [String]()
    
    private var reuseNumberCell = "NumberCell"
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentedNumbers = trainingService.numbersSoFar
        navigationController?.navigationBar .isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        numberClicked()
    }
    
    //MARK: - Helpers
    
    
    private func configureUI(){
        view.backgroundColor = ct_Color.pink
        view.addSubview(trainingView)
        trainingView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        trainingView.digit = trainingService.currentDigit
        
    }
    
    private func addTargets(){
        trainingView.numberList.forEach { (button) in
            button.addTarget(self, action: #selector(numberClicked), for: .touchUpInside)
        }
        trainingView.menuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
    }
    
    private func configureCollectionView(){
        trainingView.piNumberCollectionView.register(NumberCell.self, forCellWithReuseIdentifier: reuseNumberCell)
        trainingView.piNumberCollectionView.delegate = self
        trainingView.piNumberCollectionView.dataSource = self
        trainingView.piNumberCollectionView.alwaysBounceHorizontal = true
    }
    
    private func appendAndAdjustNumber(trainingNum:String){
        presentedNumbers.append(trainingNum)
        trainingView.digit = trainingService.currentDigit
        trainingView.piNumberCollectionView.reloadData()
        trainingView.piNumberCollectionView.scrollToItem(at: IndexPath(item: presentedNumbers.count - 1, section: 0), at: [.centeredHorizontally], animated: true)
    }
    
    
    //MARK: - Selectors
    
    @objc private func numberClicked(){
        if trainingService.isFinished == true{
            showCompleteAlert()
        }
        SoundService.shared.playSound(sound: .buttonClick)
        trainingService.getNextNumber { (numberToAppend,numberToGuide) in
            appendAndAdjustNumber(trainingNum: numberToAppend)
            trainingView.makeGuided(buttonNum: numberToGuide)
        }
    }
}

extension TrainingController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presentedNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseNumberCell, for: indexPath) as? NumberCell{
            cell.challangeNumber = PiCollectionNumber(number: presentedNumbers[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
