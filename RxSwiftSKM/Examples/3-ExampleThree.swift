//
//  ExampleThree.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 18/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class ExampleThree {
    
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
   
        let publishSubject = PublishSubject<String>()
        
        publishSubject.onNext("Hello")
        
        let sub1 = publishSubject.subscribe { event in
            print("Sub1")
            print(event)
        }
        
        publishSubject.onNext("World")
        let sub2 = publishSubject.subscribe { event in
            print("Sub2")
            print(event)
        }
        
        publishSubject.onNext("Again")
        publishSubject.onError(CustomError.someError)
        let sub3 = publishSubject.subscribe { event in
            print("Sub3")
            print(event)
        }
        
        publishSubject.onNext("After error")
        
        let sub4 = publishSubject.subscribe { event in
            print("I'm new")
            print(event)
        }
        
        publishSubject.onNext("After error to the new guy")
    }
    
    //Questions:
    //0. How to reset subject?
    
    func two() {
        let behaviorSubject = BehaviorSubject(value: 10)
        
        behaviorSubject.onNext(15)
        
        let sub1 = behaviorSubject.subscribe { event in
            print("sub1 \(event)")
        }
        
        behaviorSubject.onNext(20)
        
        let sub2 = behaviorSubject.subscribe { event in
            print("sub2 \(event)")
        }
        
        behaviorSubject.onError(CustomError.someError)

        let sub3 = behaviorSubject.subscribe { event in
            print("sub3 \(event)")
        }
        
        behaviorSubject.onNext(30)

    }
    
    func three() {
        
        let replaySubject = ReplaySubject<Int>.create(bufferSize: 1)
        replaySubject.onNext(22)
        
        let sub1 = replaySubject.subscribe { event in
            print("sub1 \(event)")
        }
        
        replaySubject.onNext(33)
        let sub2 = replaySubject.subscribe { event in
            print("sub2 \(event)")
        }
        
        replaySubject.onNext(44)
        
        let sub3 = replaySubject.subscribe { event in
            print("sub3 \(event)")
        }
        
        replaySubject.onError(CustomError.someError)
        
        let sub4 = replaySubject.subscribe { event in
            print("sub4 \(event)")
        }
        
        replaySubject.onNext(55)
    }
    
}
