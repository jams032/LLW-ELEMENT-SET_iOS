//
//  ViewController.swift
//  LLW-ELEMENT-SET_iOS
//
//  Created by Admin on 17/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var finalElements: UILabel!
        
        var items = [ElementSet]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            items.append(ElementSet())
            items.append(ElementSet())
            items.append(ElementSet())
            items.append(ElementSet())
            items.append(ElementSet())
            items.append(ElementSet())
            items.append(ElementSet())
            items.append(ElementSet())

        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func formatElementsForDisplay(_ element: ElementSet) -> String {
            let numbers = element.converged().map { "\($0.value)" }
            let timeStamps = element.converged().map { "\($0.timestamp)" }
            let strTimes = timeStamps.joined(separator: ", ")
            let str = numbers.joined(separator: ", ")
            
            var result = zip(str, strTimes).flatMap { [$0.0, $0.1] }
            
            return str
        }
    }

    extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return items.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            let item = items[indexPath.row]
            cell.delegate = self
            cell.elementSet = item
            let str = formatElementsForDisplay(item)
            cell.elements.text = str
            cell.replicaNo.text = "Replica \(indexPath.row+1)"
            return cell
        }
    }

    extension ViewController: CollectionViewCellDelegate {
        func didChange(elementSet: ElementSet?) {
            if let index = items.index(where: { $0 === elementSet }) {
                items[index] = elementSet!
                collectionView.reloadData()
                let merged = ElementSet.mergedItems(items)
                let str = formatElementsForDisplay(merged)
                finalElements.text = str
            }
        }
    }

