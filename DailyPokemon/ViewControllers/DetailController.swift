//
//  DetailController.swift
//  DailyPokemon
//
//  Created by Anton Martsenyuk on 8/7/19.
//  Copyright © 2019 Anton Martsenyuk. All rights reserved.
//

import UIKit


class DetailController: UIViewController {
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var imageIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weaknessesLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    var pokemon: Poke?
    
    var name = "Name: " {
        didSet {
            nameLabel.text = name
        }
    }
    var type = "Type: " {
        didSet {
            typeLabel.text = type
        }
    }
    var weaknesses = "Weaknesses: " {
        didSet {
            weaknessesLabel.text = weaknesses
        }
    }
    var weight = "Weight: " {
        didSet {
            weightLabel.text = weight
            
        }
    }
    var height = "Height: " {
        didSet {
            heightLabel.text = height
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeImageView.alpha = 0
        imageIndicatorView.isHidden = false
        imageIndicatorView.startAnimating()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose(tap:))))
        
        if let checkPoke = pokemon {
            name += checkPoke.name
            type += checkPoke.type.first!
            weaknesses += checkPoke.weaknesses.first!
            weight += checkPoke.weight
            height += checkPoke.height
            
            let imgUrl = URL(string: checkPoke.img)
            if let url = imgUrl {
                loadImage(url: url)
            }
        }
    }
    
    @objc func actionClose(tap: UITapGestureRecognizer) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func loadImage(url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                UIView.animate(withDuration: 1.5) {
                    self.imageIndicatorView.stopAnimating()
                    self.imageIndicatorView.isHidden = true
                    self.pokeImageView.alpha = 1
                }
                self.pokeImageView.image = UIImage(data: data)
                self.pokeImageView.contentMode = .scaleAspectFit
            }
        }
    }

}
