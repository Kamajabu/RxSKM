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
//                two()
        
//        four()
    }
    
    func one() {
        
        //    If you place this code in a viewDidLoad you will block the main thread because of the usage of sleep in the subscription code.
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
        
        //This time you will switch threads while subscribing:
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
        
        //You can place observeOn and subscribeOn anywhere in your operator chain - the order doesn’t really matter.
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
