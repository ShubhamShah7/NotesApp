//
//  DataService.swift
//  NotesApp
//
//  Created by Shubham Shreemankar on 15/07/21.
//

import Foundation
class DataService {
    
    static func getDocDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print("Doc Dir : \(paths)")
        return paths[0]
    }
}
