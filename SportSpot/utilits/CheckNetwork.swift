//
//  CheckNetwork.swift
//  SportSpot
//
//  Created by Michael Magdy on 29/04/2024.
//


import Foundation
import Reachability

protocol CheckNetworkDelegate: AnyObject {
    func showNoNetworkAlert()
}

class CheckNetwork {
    
    let reachability = try! Reachability()
    weak var delegate: CheckNetworkDelegate?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged(_:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkChanged(_ notification: Notification) {
        let reachability = notification.object as! Reachability
        if reachability.connection == .unavailable {
            delegate?.showNoNetworkAlert()
        }else {
            print("Conntected")
        }
    }
    
    func isConnected() -> Bool {
        return reachability.connection != .unavailable
    }
    
    deinit {
        reachability.stopNotifier()
    }
}
