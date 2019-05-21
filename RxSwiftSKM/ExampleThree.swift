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
//                one()
//                two()
//                three()
        four()
    }
    func one() {
        
        let observable = Observable.of(1, 2, 3).debug()
        
        observable.subscribe(onNext: { element in
            print(element)
        })
        
    }
    
    func two() {
        
        let observable = Observable.of(1, 2, 3).debug()
        
        observable.first().subscribe(onSuccess: { element in
            print(element)
        })
        
    }
    
    func three() {
   
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
    
//    In the code above, the event .on(.Next(“Hello”)) is lost since no subscribers are listening at that time.
    
    //Questions:
    //0. How to reset subject?
    
    
    func four() {
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
        
//        It is important to note that when an error or completed event has occurred with the subject, future observers who subscribe are passed the error or completed event. The last next event is not passed to the new observer.

    }
    
    func five() {
        
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
        
//        It is important to note that when an error or completed event has occurred with the subject, future observers who subscribe are passed the n buffer along with the error or completed event. This is different from other subjects seen above. And this is the reason that, with a buffer of 1 — ReplaySubject is not the same as a BehaviorSubject.

    }
}
