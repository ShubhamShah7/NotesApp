import UIKit

class NewNoteVC: UIViewController {

    var updateFile = ""
    
    private let fileNameTextField:UITextField = {
       let txt = UITextField()
        txt.placeholder = "File Name"
        txt.textAlignment = .center
        txt.borderStyle = .roundedRect
        txt.backgroundColor = .white
        txt.autocapitalizationType = .none
        txt.textColor = .black
        return txt
    }()
    
    private let contentTextField:UITextField = {
       let txt = UITextField()
        txt.borderStyle = .roundedRect
        txt.backgroundColor = .white
        txt.textColor = .black
        return txt
    }()
    
    private let saveButton:UIButton = {
       let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        btn.backgroundColor = .systemGreen
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    @objc private func saveNote()
    {
        let name = fileNameTextField.text!
        let content = contentTextField.text!
        
        let filePath = DataService.getDocDir().appendingPathComponent("\(name).txt")
        
        do{
            try content.write(to: filePath, atomically: true, encoding: .utf8)
            
            let fetchedContent = try String(contentsOf: filePath)
            print(fetchedContent)
            
            fileNameTextField.text = ""
            contentTextField.text = ""
            
            let alert = UIAlertController(title: "Success", message: "File Saved Successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: {[weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            
        } catch {
            print(error)
        }
        
        print("File Name is : \(name)")
        print("Content is : \(content)")
        print("Button Clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add New Note"
        view.self.backgroundColor = .cyan
        
        view.addSubview(fileNameTextField)
        view.addSubview(contentTextField)
        view.addSubview(saveButton)
        
        if updateFile != "" {
            title = "Update Note"
            fileNameTextField.text = updateFile.components(separatedBy: ".").first
            fileNameTextField.isEnabled = false
            
            let filePath = DataService.getDocDir().appendingPathComponent(updateFile)
            
            do{
                let content = try String(contentsOf: filePath)
                contentTextField.text = content
            } catch {
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        fileNameTextField.frame = CGRect(x:40,y:view.safeAreaInsets.top+20, width: view.width-80, height: 40)
        contentTextField.frame = CGRect(x:40, y:fileNameTextField.bottom+20, width: view.width-80, height: 300)
        saveButton.frame = CGRect(x:40, y:contentTextField.bottom+20, width: view.width - 80, height: 40)
    }
}
