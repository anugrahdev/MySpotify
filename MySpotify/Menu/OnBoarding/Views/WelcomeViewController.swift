import UIKit
import RxCocoa


class WelcomeViewController: BaseViewController {
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        
        signInButton.rx.tap.bind{ [weak self] in
            
            let auth = AuthViewController()
            auth.navigationItem.largeTitleDisplayMode = .never
            auth.completionHandler = { [weak self] success in
                DispatchQueue.main.async {
                    self?.handleSignIn(success: success)
                }
            }
            self?.navigationController?.pushViewController(auth, animated: true)
            
        }.disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20, y: view.frame.height-50-view.safeAreaInsets.bottom, width: view.frame.width-40, height: 50)
    }
    
    private func handleSignIn(success:Bool){
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Something wrong when signing in...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true, completion: nil)
    }
}
