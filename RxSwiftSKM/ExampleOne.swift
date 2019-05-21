//
//  ExampleOne.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 18/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa


class ExampleOne {
    
    
    func start() {
//        one()
//        two()
//        three()
    }
    
    
    func one() {
        
        print("Creating observable")
        let myObservable = Observable.just(1).publish()
        
        print("Subscribing")
        myObservable.subscribe(onNext: {
            print("first = \($0)")
        })
        
        myObservable.subscribe(onNext: {
            print("second = \($0)")
        })
        
        delay(2) {
            print("Calling connect after 2 seconds")
            myObservable.connect()
        }
        
    }
    
    func two() {
        
        print("Starting at 0 seconds")
        let myObservable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .publish()
        myObservable
            .connect()
        
        var mySubscription: Disposable?
        
        delay(2) {
            mySubscription = myObservable.subscribe(onNext: {
                print("Next: \($0)")
            })
        }
        
        delay(4) {
            print("Disposing at 3 seconds")
            mySubscription?.dispose()
        }
        
        delay(6) {
            print("Subscribing again at 6 seconds")
            myObservable.subscribe(onNext: {
                print("Next: \($0)")
            })
        }
    }
    
    func three() {
        print("Starting at 0 seconds")
        let myObservable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .publish()
            .refCount()
        
        let mySubscription = myObservable.subscribe(onNext: {
            print("Next: \($0)")
        })
        
        delay(3) {
            print("Disposing at 3 seconds")
            mySubscription.dispose()
        }
        
        delay(6) {
            print("Subscribing again at 6 seconds")
            myObservable.subscribe(onNext: {
                print("Next: \($0)")
            })
        }
        
    }
}
    
    
    //Questions:
    //0. Would (two separate lines)
    // let myObservable = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
    // myObservable.refCount()
    // also work?


    
