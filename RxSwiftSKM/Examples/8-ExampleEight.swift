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

//http://rx-marin.com/post/observeon-vs-subscribeon/

class ExampleEight {
    
    func start() {
        //        one()
        //        two()
    }
    
    func one() {
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            sleep(1)
            observer.onNext(2)
            return Disposables.create()
            }
            .subscribe(onNext: { el in
                print(Thread.isMainThread)
            })
    }
    
    func two() {
        Observable<Int>.create { observer in
            observer.onNext(1)
            sleep(1)
            observer.onNext(2)
            return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { el in
                print(Thread.isMainThread)
            })
    }
    
    func three() {
        Observable<Int>.create { observer in
            observer.onNext(1)
            sleep(1)
            observer.onNext(2)
            return Disposables.create()
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { el in
                print(Thread.isMainThread)
            })
    }
    
    
}

