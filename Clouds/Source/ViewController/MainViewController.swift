//
//  MainViewController.swift
//  Clouds
//
//  Created by Omar Allaham on 3/16/17.
//  Copyright © 2017 Bemaxnet. All rights reserved.
//

import UIKit

typealias MainLoader = MainViewController
typealias MainPlayerDelegate = MainViewController
typealias MainUpdater = MainViewController
typealias MainCollectionView = MainViewController

class MainViewController: UIViewController {

   @IBOutlet weak var collectionView: UICollectionView!

   @IBOutlet weak var bottomView: BottomView!

   var dataSource: [Airport] = [] {
      didSet{
         collectionView.reloadData()
      }
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
   }
}

extension MainLoader {
   override func viewDidLoad() {
      super.viewDidLoad()

      setup()

      bottomView.setup()

      collectionView.register(TitleCollectionReusableView.self)
      collectionView.register(AirportCollectionViewCell.self)

      collectionView.allowsSelection = true

      dataSource.append(contentsOf: dataSource)
      dataSource.append(contentsOf: dataSource)

      Player.shared.delegate = self

//      DataManager.main.get(type: Airport.self, onUpdate: onUpdate)

      onUpdate(DataManager.main.load())
   }

   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

      UIView.animate(withDuration: 0.5) {
         self.collectionView.collectionViewLayout.invalidateLayout()
         self.collectionView.layoutIfNeeded()
      }
   }
}

extension MainPlayerDelegate: PlayerDelegate {
   func player(stateChanged state: PlayerState) {
      bottomView.isPlaying = state == .playing
   }
}

extension MainUpdater {
   func onUpdate(_ airports: [Airport]) {
      dataSource = airports
   }
}

extension MainCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {

   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
   {
      return CGSize(width: 100, height: 100)
   }

   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return dataSource.count
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

      let item = dataSource[indexPath.row]

      let cell = collectionView.cell(AirportCollectionViewCell.self, indexPath: indexPath)

//      cell.isAcitve = Player.shared.airport == item && Player.shared.isPlaying

      cell.setup(item)

      return cell
   }

   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let item = dataSource[indexPath.row]

      setAttributedTitle(item.title)

      Player.shared.airport = item
      Player.shared.play()
   }

   func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      Player.shared.pause()
   }

   func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
      let cell = collectionView.cellForItem(at: indexPath)
      cell?.layoutSubviews()
   }
}
