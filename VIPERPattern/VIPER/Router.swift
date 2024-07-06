//
//  Router.swift
//  VIPERPattern
//
//  Created by 신승아 on 7/6/24.
//

import Foundation
import UIKit


// MARK: - AnyRouter 프로토콜 정의


// EntryPoint 타입 별칭 정의: AnyView 및 UIViewController를 준수하는 타입을 나타냄
typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    // entry 속성: 시작점을 나타내는 EntryPoint 타입의 옵셔널 변수
    var entry: EntryPoint? { get }
    // start 메서드: AnyRouter 타입의 인스턴스를 생성하는 메서드
    static func start() -> AnyRouter
}



// MARK: - UserRouter 클래스 정의, AnyRouter 프로토콜 준수

class UserRouter: AnyRouter {
    
    // entry 속성: UserRouter 클래스의 시작점을 나타냄
    var entry: EntryPoint?
    
    // start 메서드: UserRouter 인스턴스를 생성하고 VIP 패턴을 설정하여 반환
    static func start() -> AnyRouter {
        // UserRouter 인스턴스 생성
        let router = UserRouter()
        
        // VIP 패턴의 각 구성요소를 생성
        // UserViewController 인스턴스를 AnyView 타입으로 생성
        var view: AnyView = UserViewController()
        
        // UserPresenter 인스턴스를 AnyPresenter 타입으로 생성
        var presenter: AnyPresenter = UserPresenter()
        
        // UserInteractor 인스턴스를 AnyInteractor 타입으로 생성
        var interactor: AnyInteractor = UserInteractor()
        
        // view의 presenter 속성에 presenter 인스턴스 할당
        view.presenter = presenter
        
        // interactor의 presenter 속성에 presenter 인스턴스 할당
        interactor.presenter = presenter
        
        // presenter의 router 속성에 router 인스턴스 할당
        presenter.router = router
        
        // presenter의 router 속성에 view 인스턴스 할당
        presenter.view = view
        
        // presenter의 interactor 속성에 interactor 인스턴스 할당
        presenter.interactor = interactor
        
        // router의 entry 속성에 view를 EntryPoint 타입으로 캐스팅하여 할당
        router.entry = view as? EntryPoint
        
        return router
    }
}
