//
//  Presenter.swift
//  VIPERPattern
//
//  Created by 신승아 on 7/6/24.
//

import Foundation

// Object
// protocol
// ref to interactor, router, view


// MARK: - AnyPresenter 프로토콜 정의

protocol AnyPresenter {
    // router 속성: AnyRouter 타입의 옵셔널 변수.
    var router: AnyRouter? { get set }
    // interactor 속성: AnyInteractor 타입의 옵셔널 변수.
    var interactor: AnyInteractor? { get set }
    // view 속성: AnyView 타입의 옵셔널 변수.
    var view: AnyView? { get set }
    
    // 결과를 받아서 처리하는 메서드.
    func interactorDidFetchUsers(with result: Result<Content,Error>)
}


// MARK: - UserPresenter 클래스 정의, AnyPresenter 프로토콜 준수

class UserPresenter: AnyPresenter {
    
    // router 속성: AnyRouter 타입의 옵셔널 변수.
    var router: AnyRouter?
    
    // interactor 속성: AnyInteractor 타입의 옵셔널 변수.
    var interactor: AnyInteractor? {
        // interactor가 설정되면 getUsers 메서드를 호출.
        didSet {
            interactor?.getUsers()
        }
    }
    
    // view 속성: AnyView 타입의 옵셔널 변수.
    var view: AnyView?
    
    // 결과를 받아서 처리하는 메서드.
    func interactorDidFetchUsers(with result: Result<Content, Error>) {
        switch result {
        
        // 성공 케이스: users를 받아서 view의 update 메서드 호출.
        case .success(let users):
            view?.update(with: users.text)
        
        // 실패 케이스: "Something went wrong" 메시지로 view의 update 메서드 호출.
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
}
