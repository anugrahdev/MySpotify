//
//  ViewController.swift
//  MySpotify
//
//  Created by Anang Nugraha on 15/09/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
    }
    
    @objc func didTapSettings(){
        let settings = SettingsViewController()
        settings.title = "Settings"
        settings.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(settings, animated: true)
    }


}

