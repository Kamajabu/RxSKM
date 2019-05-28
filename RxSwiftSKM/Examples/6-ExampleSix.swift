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
//        one()
//        two()
//        three()
    }
    
    func one() {
        var updatedValue: Int = 0
        
        var observedValue: Observable<Int> {
            return Observable.of(updatedValue)
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
    
    func three() {
        
        let subject = PublishSubject<Int>()
        
        let observableOf = Observable.of(1,2,3)
        
        let combined = Observable.combineLatest(subject, observableOf).debug("combineLatest").share()
        
        combined.debug("normal").subscribe { (event) in
            print("combine: \(event)")
        }
        
        combined.debug("withLatestFrom").withLatestFrom(subject).subscribe { (event) in
            print("withLatestFrom: \(event)")
        }
     
        subject.onNext(111)
        subject.onNext(222)
        subject.onNext(333)


//        2019-05-27 20:51:08.400: withLatestFrom -> subscribed
//        2019-05-27 20:51:08.402: combineLatest -> subscribed
//        2019-05-27 20:51:08.404: normal -> subscribed
//        2019-05-27 20:51:08.406: combineLatest -> Event next((111, 3))
//        2019-05-27 20:51:08.406: withLatestFrom -> Event next((111, 3))
//        withLatestFrom: next(111)
//        2019-05-27 20:51:08.406: normal -> Event next((111, 3))
//        combine: next((111, 3))
//        2019-05-27 20:51:08.406: combineLatest -> Event next((222, 3))
//        2019-05-27 20:51:08.406: withLatestFrom -> Event next((222, 3))
//        withLatestFrom: next(222)
//        2019-05-27 20:51:08.406: normal -> Event next((222, 3))
//        combine: next((222, 3))
//        2019-05-27 20:51:08.406: combineLatest -> Event next((333, 3))
//        2019-05-27 20:51:08.407: withLatestFrom -> Event next((333, 3))
//        withLatestFrom: next(333)
//        2019-05-27 20:51:08.407: normal -> Event next((333, 3))
//        combine: next((333, 3))
        
        
        //---
        
//
//        2019-05-27 20:52:29.220: normal -> subscribed
//        2019-05-27 20:52:29.223: combineLatest -> subscribed
//        2019-05-27 20:52:29.226: withLatestFrom -> subscribed
//        2019-05-27 20:52:29.227: combineLatest -> Event next((111, 3))
//        2019-05-27 20:52:29.227: normal -> Event next((111, 3))
//        combine: next((111, 3))
//        2019-05-27 20:52:29.227: withLatestFrom -> Event next((111, 3))
//        2019-05-27 20:52:29.227: combineLatest -> Event next((222, 3))
//        2019-05-27 20:52:29.227: normal -> Event next((222, 3))
//        combine: next((222, 3))
//        2019-05-27 20:52:29.227: withLatestFrom -> Event next((222, 3))
//        withLatestFrom: next(111)
//        2019-05-27 20:52:29.227: combineLatest -> Event next((333, 3))
//        2019-05-27 20:52:29.228: normal -> Event next((333, 3))
//        combine: next((333, 3))
//        2019-05-27 20:52:29.228: withLatestFrom -> Event next((333, 3))
//        withLatestFrom: next(222)


        
    }
    
}
