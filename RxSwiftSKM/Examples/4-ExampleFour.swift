//
//  ExampleFour.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 18/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

//http://rx-marin.com/post/observeon-vs-subscribeon/

class ExampleFour {
    
    func start() {
//        one()
//        two()
//        three()
//        four()
    }
    
    func one() {
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            print("Hello o/")
        }
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            sleep(3)
            observer.onNext(2)
            return Disposables.create()
            }
            .subscribe(onNext: { el in
                print("is main thread: \(Thread.isMainThread)")
            })
    }
    

    
    func two() {
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            print("Hello o/")
        }
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            sleep(3)
            observer.onNext(2)
            return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { el in
                print("is main thread: \(Thread.isMainThread)")
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
                print("is main thread: \(Thread.isMainThread)")
            })
    }
    
    func four() {
        let switchOnOff = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            sleep(1)
            observer.onNext(2)
            return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { el in
                switchOnOff.isOn = true
            })
    }
    
    func five() {
        //fix for above?
    }
    
}
