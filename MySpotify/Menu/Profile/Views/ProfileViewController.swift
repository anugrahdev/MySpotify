//
//  ProfileViewController.swift
//  MySpotify
//
//  Created by Anang Nugraha on 28/09/21.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var models = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        fetchProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func fetchProfile() {
        NetworkService().getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let model):
                self?.updateUI(with: model)
            case .failure(_):
                self?.failedToGetProfile()
            }
        }
    }
    
    private func updateUI(with model: ProfileModel) {
        tableView.isHidden = false
        models.append("Full Name: \(model.displayName ?? "")")
        models.append("Email Address: \(model.email ?? "")")
        models.append("User ID: \(model.id ?? "")")
        models.append("Plan: \(model.product ?? "")")
        createTableHeader(with: model.images?.first?.url)
        tableView.reloadData()
    }
    
    private func createTableHeader(with url: String?){
        guard let url = url, let imageUrl = URL(string: url) else {
            return
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.25))
        
        let imageSize: CGFloat = headerView.frame.height / 2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        
        headerView.addSubview(imageView)
        imageView.kf.setImage(with: imageUrl)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        
        tableView.tableHeaderView = headerView

    }
    
    private func failedToGetProfile(){
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
        
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = "\(models[indexPath.row])"
        return cell
    }
    
    
    
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ProfileViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        ProfileViewController().showPreview()
            .previewLayout(.sizeThatFits)
    }
}
#endif
