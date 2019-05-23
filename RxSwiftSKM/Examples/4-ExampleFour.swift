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

class ExampleFour {
    
    
    enum CustomError: Error {
        case someError
    }
    
    
    func start() {
        two()
        //                one()
        //                two()
        //                three()
//        four()
    }
    func one() {
        
        func sampleCreate() -> Observable<String> {
            return Observable.create { observer in
                observer.on(.next("Hello"))
                observer.on(.next("World"))
                print("sleeping")
                Thread.sleep(forTimeInterval: 2.0)
                print("slept")
                observer.onCompleted()
                
                return Disposables.create()
            }
        }
        
        sampleCreate().subscribe { event in
            print(event)
        }
        
//        As you see, the sequence is lazily evaluated and the next events are processed before we sleep on the rest of the instructions.
        
    }
    
    func two() {
        
        func sampleSubject() -> ReplaySubject<String> {
            let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
            
            replaySubject.on(.next("Hello"))
            replaySubject.on(.next("World"))
            print("sleeping")
            Thread.sleep(forTimeInterval: 2.0)
            print("slept")
            replaySubject.onCompleted()
            
            return replaySubject
        }
        
        sampleSubject().subscribe { event in
            print(event)
        }
        
//        The subject implements a blocking kind of sequence generation, and the events are processed together and not lazily evaluated.
        
    }
}
