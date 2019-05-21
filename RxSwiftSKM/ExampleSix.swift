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
    
    
    
    enum CustomError: Error {
        case someError
    }
    
    
    func start() {
        one()
//        two()
        

    }
    
    @objc dynamic var updatedValue: Int = 0

    
    func one() {
        
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
    
    
    func two() {
        var updatedValue: Int = 0
        
        var observedValue: Observable<Int> {
            return Observable.create({ (observer) -> Disposable in
                observer.onNext(updatedValue)
                return Disposables.create()
            })
        }
        
        func newBackgroundTimer() -> Void {
            DispatchQueue.global(qos: .background).async {
                let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    updatedValue = updatedValue + 1;
                }
                let runLoop = RunLoop.current
                runLoop.add(timer, forMode: RunLoop.Mode.common)
                runLoop.run()
            }
        }
        
        newBackgroundTimer()

        
//        let myObservable2 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)

        
        let myObservable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//            .publish()
        
//        myObservable.connect()
        
        myObservable
            .debug("Main stream", trimOutput: true)
            .withLatestFrom(observedValue.debug("Latest from", trimOutput: true))
            .subscribe { (event) in
                print("Subscription \(event)")
        }
        

        
    }
    
    
    func three() {
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
    
}
