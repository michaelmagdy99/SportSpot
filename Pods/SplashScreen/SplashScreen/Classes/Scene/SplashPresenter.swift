//
//  SplashPresenter.swift
//  SmartMic
//
//  Created by Marcel Mendes Filho on 09/08/19.
//  Copyright (c) 2019 Marcel Mendes Filho. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SplashPresentationLogic
{
    func updateSplash()
    func couldNotGetSpash(error: String)
    func dismissSplashScreen()
}

class SplashPresenter: SplashPresentationLogic
{
    weak var viewController: SplashDisplayLogic?
    
    func updateSplash(){
        viewController?.updateSplash()
    }

    func couldNotGetSpash(error: String){
        viewController?.showAlert(title: "Error", message: "Could not get information to display. Reason: \(error)", buttonLabel: "Ok")
    }
    
    func dismissSplashScreen(){
        viewController?.dismissSplashScreen()
    }
  
  // MARK: Do something
  
}
