//
//  ExampleFive.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 18/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

import RxSwift

extension ObservableType where E: EventConvertible {
    
    /**
     Returns an observable sequence containing only next elements from its input
     - seealso: [materialize operator on reactivex.io](http://reactivex.io/documentation/operators/materialize-dematerialize.html)
     */
    public func elements() -> Observable<E.ElementType> {
        return filter { $0.event.element != nil }
            .map { $0.event.element! }
    }
    
    /**
     Returns an observable sequence containing only error elements from its input
     - seealso: [materialize operator on reactivex.io](http://reactivex.io/documentation/operators/materialize-dematerialize.html)
     */
    public func errors() -> Observable<Swift.Error> {
        return filter { $0.event.error != nil }
            .map { $0.event.error! }
    }
}

class ExampleFive {
    
    
    enum CustomError: Error {
        case someError
    }
    
    
    class TestToWatch {
        
        var someFlag = 0
        
        init() {
            delay(3) {
                self.someFlag = 1
            }
        }
        
    }
    
    
    func start() {
        one()
    }
    
    func one() {
       
        let result = Observable
            .of(true, true, false, true, false, true, true)
            .flatMap { [unowned self] performWithSuccess in
                return self.performAPICall(shouldEndWithSuccess: performWithSuccess)
                    .materialize()
        }
        
        
        result
            .scan(0) { accumulator, _ in
                return accumulator + 1
            }.map { "\($0)" }
            .subscribe({ event in
                print(event)
            })
        
        
    }
    
    private func performAPICall(shouldEndWithSuccess: Bool) -> Observable<Void> {
        if shouldEndWithSuccess {
            return .just(())
        } else {
            return .error(CustomError.someError)
        }
    }
}
