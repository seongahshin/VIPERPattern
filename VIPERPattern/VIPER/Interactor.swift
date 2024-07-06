//
//  Interactor.swift
//  VIPERPattern
//
//  Created by 신승아 on 7/6/24.
//

import Foundation

// object
// portocol
// ref to presenter

enum FetchError: Error {
    case failed
}

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {

        guard let url = URL(string: "http://numbersapi.com/42?json") else { return }
        
        let tasks = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                self.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode(Content.self, from: data)
                self.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self.presenter?.interactorDidFetchUsers(with: .failure(error))
                print("catch error")
            }
            
        }
        
        tasks.resume()
    }
    
    
}
