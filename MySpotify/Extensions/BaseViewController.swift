//
//  BaseViewController.swift
//  MySpotify
//
//  Created by Anang Nugraha on 18/09/21.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    var vSpinner : UIView?
    public var disposeBag = DisposeBag()
    
    func showAlert(title: String, message: String) {
        self.removeSpinner()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .clear
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
}
