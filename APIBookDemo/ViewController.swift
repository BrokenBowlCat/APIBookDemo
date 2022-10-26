//
//  ViewController.swift
//  APIBookDemo
//
//  Created by 03PKK on 2022/10/25.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogLabel: UILabel!
    @IBOutlet weak var changeButtom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
//        UIUpdate()
    }
    var randomDogClass:randomDog?
    
    func callAPI() {
        let urlString = "https://some-random-api.ml/animal/dog"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response , error in
                if let data {
                    let decoder = JSONDecoder()
                    do {
                        let randomDog = try decoder.decode(randomDog.self, from: data)
//                        print(randomDog)
                        DispatchQueue.main.async {
//                            let temp = randomDog.fact
//                            print(temp)
                            self.dogLabel.text = randomDog.fact

                            let sureUrl = randomDog.image
                            URLSession.shared.dataTask(with: sureUrl) { data, response, error in
                                if let data = data {
                                        DispatchQueue.main.async {
                                            self.dogImage.image =  UIImage(data: data)
                                            
                                    }
                                }
                            }.resume()
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }

    @IBAction func againButton(_ sender: Any) {
        callAPI()
    }
}
