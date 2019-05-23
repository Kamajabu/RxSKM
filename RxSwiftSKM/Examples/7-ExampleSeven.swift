//
//  7-ExampleSeven.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 22/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class ExampleSeven {
    
    func start() {
        //        one()
        //        two()
    }
    
    func one() {
        let S1 = Observable.of(1,2)
        let S2 = Observable.of(3,4,5)
        let S3 = Observable.of(6,7)
        
        Observable.combineLatest(S1, S2, S3) { value1, value2, value3 in
            print("latest values: ... \(value1) and \(value2) and \(value3)")
            }.subscribe { (event) in
                print("multi \(event)")
        }
        
        let sources = [S1, S2, S3]
        
        Observable.combineLatest(sources) { value in
            print("latest values: ... \(value)")
            }.subscribe { (event) in
                print("multi \(event)")
        }
    }
    
    func two() {
        let S1 = Observable.of(1,2)
        let S2 = Observable.of(3,4,5)
        let S3 = Observable.of(6,7)
        
        Observable.zip(S1, S2, S3) { value1, value2, value3 in
            print("latest values: ... \(value1) and \(value2) and \(value3)")
            }.subscribe { (event) in
                print("multi \(event)")
        }
        
        let sources = [S1, S2, S3]
        
        Observable.zip(sources) { value in
            print("latest values: ... \(value)")
            }.subscribe { (event) in
                print("multi \(event)")
        }
    }
    
    func three() {
        let S1 = Observable.of(1,2)
        let S2 = Observable.of(3,4,5)
        let S3 = Observable.of(6,7)
        
        Observable.combineLatest(S1, S2, S3) { value1, value2, value3 in
            print("latest values: ... \(value1) and \(value2) and \(value3)")
            }.subscribe { (event) in
                print("multi \(event)")
        }
        
        let sources = [S1, S2, S3]
        
        Observable.combineLatest(sources) { value in
            print("latest values: ... \(value)")
            }.subscribe { (event) in
                print("multi \(event)")
        }
    }


        
}
