import UIKit

class LoginVC: UIViewController {

    private let username:UITextField = {
      let txt = UITextField()
        txt.placeholder = "Enter Username"
        txt.borderStyle = .roundedRect
        txt.textAlignment = .center
        txt.autocapitalizationType = .none
        txt.layer.cornerRadius = 10
        txt.backgroundColor = .systemFill
        txt.layer.borderColor = UIColor.orange.cgColor
        txt.layer.borderWidth = 2
        return txt
    }()
    
    private let password:UITextField = {
      let txt = UITextField()
        txt.placeholder = "Enter Password"
        txt.borderStyle = .roundedRect
        txt.textAlignment = .center
        txt.autocapitalizationType = .none
        txt.layer.cornerRadius = 10
        txt.backgroundColor = .systemFill
        txt.layer.borderColor = UIColor.orange.cgColor
        txt.layer.borderWidth = 2
//        txt.isSecureTextEntry = true
        return txt
    }()
    
    private let signUpButton:UIButton = {
       let btn = UIButton()
        btn.setTitle("Sign Up",for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 2
        btn.backgroundColor = .systemGreen
        btn.addTarget(self, action: #selector(checkAuth), for: .touchUpInside)
        return btn
    }()
    
    @objc func checkAuth()
    {
        print("Button Clicked")
        if (username.text == "admin" && password.text == "admin")
        {
            UserDefaults.standard.setValue("sadjasafanafn", forKey: "sessionToken")
            UserDefaults.standard.setValue(username.text, forKey: "username")
            print("Success")
            let vc = WelcomwVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav, animated: true)
        }
        else
        {
            print("Username or Password is wrong")
            let alert = UIAlertController(title: "Failed", message: "Username or Password is wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
            username.text = ""
            password.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LogIn"
        view.self.backgroundColor = .systemFill
        
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(signUpButton)
     }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        username.frame = CGRect(x:50, y:view.safeAreaInsets.top+100, width: 250, height: 50)
        password.frame = CGRect(x:50, y:username.bottom + 30, width: 250,height: 50)
        signUpButton.frame = CGRect(x:50, y:password.bottom + 15, width: 250, height: 50)
    }
}
