//
//  8-ExampleEight.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 22/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

//https://medium.com/@rajkumar_p/part-2-observables-and-subjects-153b6b8ee5fb


class ExampleEight {
    
    enum CustomError: Error {
        case someError
    }
    
    
    func start() {
//        one()
//        two()
//        three()
//        four()
    }
    
    func one() {
        
        func sampleCreate() -> Observable<String> {
            return Observable.create { observer in
                observer.on(.next("Hello"))
                observer.on(.next("World"))
                print("sleeping")
                Thread.sleep(forTimeInterval: 4.0)
                observer.on(.next("Bye"))
                print("slept")
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
        
        sampleCreate().subscribe { event in
            print(event)
        }
        
    }
    
    func two() {
        
        func sampleSubject() -> ReplaySubject<String> {
            let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
            
            replaySubject.on(.next("Hello"))
            replaySubject.on(.next("World"))
            print("sleeping")
            Thread.sleep(forTimeInterval: 4.0)
            replaySubject.on(.next("Bye"))
            print("slept")
            replaySubject.onCompleted()
            
            return replaySubject
        }
        
        sampleSubject().subscribe { event in
            print(event)
        }        
    }
    
    
    func three() {
        
        let disposeBag = DisposeBag()
        var flip = false
        
        let factory: Observable<Int> = Observable.deferred {
            
            flip = !flip
            
            if flip {
                return Observable.of(1, 2, 3)
            } else {
                return Observable.of(4, 5, 6)
            }
        }
        
        for _ in 0...1 {
            factory.subscribe(onNext: {
                print($0, terminator: "")
            })
                .addDisposableTo(disposeBag)
            print()
        }
    }
    
    
    func rx_myFunction() -> Observable<Int> {
        print("rx_myFunction go!")
        let someCalculationResult: Int = calculate()
        return .just(someCalculationResult)
    }
    
    func rx_myFunctionDef() -> Observable<Int> {
        return Observable.deferred {
            print("rx_myFunctionDef go!")
            let someCalculationResult: Int = self.calculate()
            return .just(someCalculationResult)
        }
    }
    
    var value = 1
    
    func calculate() -> Int {
        return value
    }
    
    func four() {
        value = 2
        rx_myFunction().debug("normal function").subscribe(onNext: { (value) in
            print(value)
        })
        
        rx_myFunctionDef().debug("deferred function").subscribe(onNext: { (value) in
            print(value)
        })
    }
    
    
}

