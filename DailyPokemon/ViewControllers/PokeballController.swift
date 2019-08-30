//
//  ViewController.swift
//  DailyPokemon
//
//  Created by Anton Martsenyuk on 8/5/19.
//  Copyright © 2019 Anton Martsenyuk. All rights reserved.
//

import UIKit

class PokeballController: UIViewController {
    
    let transition = TransitionAnimator()
    var selectedCell = UICollectionViewCell()
    
    var pokemons: [Poke] {
        if var pokemons = getPoke() {
            pokemons.shuffle()
            return pokemons
        } else {
            return [Poke]()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transition.dismissCompletion = {
            self.selectedCell.isHidden = false
        }
    }
    
    func getPoke() -> [Poke]? {
        guard let url = Bundle.main.url(forResource: "PokeJSON", withExtension: "json") else {return nil}
        do {
            let data = try Data(contentsOf: url, options: .alwaysMapped)
            let jsonData = try JSONDecoder().decode(PokeModel.self, from: data)
            return jsonData.pokemons
        } catch {
            print("error:\(error)")
        }
        return nil
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension PokeballController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.clipsToBounds = true
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseOut,
                       animations: {cell.transform = .identity}, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        let pokemonDetailVC = storyboard!.instantiateViewController(withIdentifier: "Detail") as! DetailController
        pokemonDetailVC.pokemon = pokemons[indexPath.row]
        pokemonDetailVC.transitioningDelegate = self
        
        self.present(pokemonDetailVC, animated: true, completion: nil)
        
    }
}


extension PokeballController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let originFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else {
            return transition
        }
        transition.originFrame = originFrame
        transition.presenting = true
        selectedCell.isHidden = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
