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

    //let disposeBag = DisposeBag()
    
    func one() {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let requestObservable = URLSession.shared
            .rx.data(request: URLRequest(url: url))
        
        requestObservable
            .debug()
            .subscribe(onNext: {
                print($0)
            })
        
        requestObservable
            .debug()
            .subscribe(onNext: {
                print($0)
            })
        
    }
    
    //    If you take a look at console logs, you will see two distinct HTTP responses. Observable performed work twice even if it wasn’t our intention.
    
    //Questions:
    //0. Will this subscribtion be disposed?
    //1. Would dispose bag change here anything?
    //2. Would using dispose() instead of .disposed(by: DisposeBag) change anything?
    
    func two() {
        
        
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let requestObservable = URLSession.shared
            .rx.data(request: URLRequest(url: url))
            .share()
        //same as
        //.publish().refcount()
        
        requestObservable
            .debug()
            .subscribe(onNext: {
                print($0)
            })
        
        //sleep(3)
        print("--Next subscribe--")
        requestObservable
            .debug()
            .subscribe(onNext: {
                print($0)
            })
        
    }
    
    
    //Questions:
    //0. What would adding sleep between them change?
    
    
    
}


//        let observable = Observable<Void>.create { observer -> Disposable in
//            // run request
//            print("Live")
//
//            observer.onCompleted()
//            return Disposables.create {
//                // request.cancel()
//                print("disposed ☠️")
//            }
//        }
//
//        let disposable = observable.subscribe()
//        observable.subscribe()









































// 1. Yes, request would/could be canceled before having opportunity to be finished
// 2. Nope




