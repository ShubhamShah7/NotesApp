//
//  WelcomwVC.swift
//  NotesApp
//
//  Created by Shubham Shreemankar on 14/07/21.
//

import UIKit

class WelcomwVC: UIViewController {
    
    private var noteArray = [String]()
    private var noteState = [Int]()
    private let notesTableView = UITableView()
  
    private func fetchData()
    {
        let path = DataService.getDocDir()
        
        do {
            let items = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            noteArray.removeAll()
            
            for item in items {
                
                print(item.lastPathComponent)
                noteArray.append(item.lastPathComponent)
            }
        }catch{
            print(error)
        }
        notesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Notes"
        view.backgroundColor = .systemFill
       
        view.addSubview(notesTableView)
        print(DataService.getDocDir())
        setupTableView()
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openNewNote))
        let logOutItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutClicked))
        navigationItem.setRightBarButton(addItem, animated: true)
        navigationItem.setLeftBarButton(logOutItem, animated: true)
    }
    
    @objc private func openNewNote()
    {
        let vc = NewNoteVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func logoutClicked()
    {
        UserDefaults.standard.setValue(nil, forKey: "sessionToken")
        UserDefaults.standard.setValue(nil, forKey: "username")
        
        checkAuth()
    }
    
    private func checkAuth()
    {
        if let _ = UserDefaults.standard.string(forKey: "sessionToken"),
           let _ = UserDefaults.standard.string(forKey: "username")  {
        }
        else
        {
            let login = LoginVC()
            let nav = UINavigationController(rootViewController: login)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
        checkAuth()
        notesTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        notesTableView.frame = view.bounds
    }
}

extension WelcomwVC: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView(){
        notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "notes")
        notesTableView.dataSource = self
        notesTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(noteArray.count)
        return noteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath)
        cell.textLabel?.text = noteArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewNoteVC()
        vc.updateFile = noteArray[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let filename = noteArray[indexPath.row]
        let path = DataService.getDocDir().appendingPathComponent(filename)
        
        do{
            try FileManager.default.removeItem(at: path)
        } catch {
            print(error)
        }
        self.noteArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
