//
//  SplashViewController.swift
//  SportSpot
//
//  Created by rwan elmtary on 24/04/2024.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    var ainimation: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ainimation = .init(name: "football.json")
        ainimation!.frame = view.bounds
        ainimation!.contentMode = .scaleAspectFit
        ainimation!.loopMode = .loop
        view.addSubview(ainimation)
        ainimation!.play()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        }
        

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
