//
//  ExampleSix.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 19/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class ExampleSix: NSObject {
    
    func start() {
        one()
//        two()
    }
    
    func one() {
        var updatedValue: Int = 0
        
        var observedValue: Observable<Int> {
            return Observable.deferred {
                Observable.of(updatedValue)
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            updatedValue = updatedValue + 1;
        }
        
        let myObservable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .publish()
        
        myObservable.connect()
        
        myObservable
            .debug("Main stream", trimOutput: true)
            .withLatestFrom(observedValue.debug("Latest from", trimOutput: true))
            .subscribe { (event) in
                print(event)
        }
        
    }
    
    @objc dynamic var updatedValue: Int = 0
    
    func two() {
        
        var observedValue: Observable<Int> {
            return .just(updatedValue)
        }
        
        let test = self.rx.observe(Int.self, "updatedValue")
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            self.updatedValue = self.updatedValue + 1;
        }
        
        let myObservable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .publish()
        
        myObservable.connect()
        
        myObservable
            .withLatestFrom(test)
            .subscribe { (event) in
                print(event)
        }
        
    }
    
//    func one() {
//
//        let observable = Observable.of(1, 2, 3).debug()
//
//        observable.subscribe(onNext: { element in
//            print(element)
//        })
//
//    }
//
//    func two() {
//
//        let observable = Observable.of(1, 2, 3).debug()
//
//        observable.first().subscribe(onSuccess: { element in
//            print(element)
//        })
//
//    }
    
}
