//
//  ExampleTwo.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 18/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ExampleTwo {
    
    //    let disposeBag = DisposeBag()
    
    func start() {
        //                one()
        //                two()
//        three()
    }
    
    //    deinit {
    //        print("Bye!")
    //    }
    
    func one() {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let requestObservable = URLSession.shared
            .rx.data(request: URLRequest(url: url))
            .debug("URLRequest")
        
        requestObservable
            //            .debug("firstSubscribe")
            .subscribe(onNext: {
                print($0)
            })
        
        requestObservable
            //            .debug("secondSubscribe")
            .subscribe(onNext: {
                print($0)
            })
        
    }
    
    //Questions:
    //0. Will this subscribtion be disposed?
    //1. Would dispose bag change here anything?
    //2. Would using dispose() instead of .disposed(by: DisposeBag) change anything?
    
    func two() {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let requestObservable = URLSession.shared
            .rx.data(request: URLRequest(url: url))
            .debug("URLRequest")
            .share()
        //same as
        //.publish().refcount()
        
        requestObservable
            //            .debug("firstSubscribe")
            .subscribe(onNext: {
                print($0)
            })
        
        //sleep(3)
        
        print("--Next subscribe--")
        requestObservable
            //            .debug("secondSubscribe")
            .subscribe(onNext: {
                print($0)
            })
        
    }
    
    //Questions:
    //0. What would adding sleep between them (line 68) change?
    
    func three() {
        
        let counter = Observable<Int>.interval(1, scheduler: SerialDispatchQueueScheduler(qos: .background))
            .debug("Conter")
            .share(replay: 2)
        
        print("Started ----")
        
        let subscription1 = counter
            .subscribe(onNext: { n in
                print("First \(n)")
            })
        
        Thread.sleep(forTimeInterval: 3.5)
        print("Second subscription ----")

        let subscription2 = counter
            .subscribe(onNext: { n in
                print("Second \(n)")
            })
        
        Thread.sleep(forTimeInterval: 4)
        print("First dispose ----")

        subscription1.dispose()
        
        Thread.sleep(forTimeInterval: 4)

        print("Second dispose ----")
        subscription2.dispose()
        
        print("Ended ----")
        
    }
    
}














































