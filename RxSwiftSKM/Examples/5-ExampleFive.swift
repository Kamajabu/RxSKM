//
//  ExampleFive.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 18/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import Foundation
import RxSwift

//https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Traits.md#driver

class ExampleFive {
    
    enum CustomError: Error {
        case someError
    }
    
    func start() {
//        one()
//        two()
//        three()
//        four()
    }
    
    
    let disposeBag = DisposeBag()
    
    func one() {
        
        func fetchAutoCompleteItems(_ query: String) -> Observable<[String]> {
            return Observable.create({ (observer) -> Disposable in
                sleep(1)
                observer.onNext(["network response", query])
                observer.onCompleted()
                return Disposables.create()
            })
        }
        
        //Do not get idea this could be used in testing flows, we have better tools ;)
        let queryTest = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("tes")
            sleep(1)
            observer.onNext("test!")
            sleep(2)
            observer.onNext("second test!")
            return Disposables.create()
        }
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        let resultCount = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))

        let results = queryTest// query.rx.text
            .debug("results")
            .throttle(1.2, scheduler: MainScheduler.instance)
            .flatMapLatest { query in
                fetchAutoCompleteItems(query)
        }
        
        results
            .debug("resultCount")
            .map { "\($0.count)" }
            .bind(to: resultCount.rx.text)
            .disposed(by: disposeBag)
        
        results
            .debug("textLabel")
            .map { "Hello from \($0)" }
            .bind(to: textLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        //        Another example of bind:
        
//        results
//            .bind(to: resultsTableView.rx.items(cellIdentifier: "Cell")) { (_, result, cell) in
//                cell.textLabel?.text = "\(result)"
//            }
//            .disposed(by: disposeBag)
        
    }
    
    
//    2019-05-23 23:23:39.069: resultCount -> subscribed
//    2019-05-23 23:23:39.072: results -> subscribed
//    2019-05-23 23:23:39.073: results -> Event next(tes)
    
    //Pierwszy event
    
//    2019-05-23 23:23:40.074: resultCount -> Event next(["network response", "tes"])
    
    //Pierwsza odpowiedz
    
//    2019-05-23 23:23:41.075: results -> Event next(test!)
    
    //Throttle, wiec brak zapytania
    
//    2019-05-23 23:23:43.078: results -> Event next(second test!)
    
    //Trzecie zapytanie
    
//    2019-05-23 23:23:44.079: resultCount -> Event next(["network response", "second test!"])
    
//    2019-05-23 23:23:44.079: textLabel -> subscribed
    
    //Kolejna labelka pyta, wiec lecimy od nowa...
    
//    2019-05-23 23:23:44.080: results -> subscribed
//    2019-05-23 23:23:44.080: results -> Event next(tes)
//    2019-05-23 23:23:45.080: textLabel -> Event next(["network response", "tes"])
//    2019-05-23 23:23:46.081: results -> Event next(test!)
//    2019-05-23 23:23:48.081: results -> Event next(second test!)
//    2019-05-23 23:23:49.082: textLabel -> Event next(["network response", "second test!"])
    
//    2019-05-23 23:23:49.083: resultCount -> isDisposed
//    2019-05-23 23:23:49.083: results -> isDisposed
//    2019-05-23 23:23:49.083: textLabel -> isDisposed
//    2019-05-23 23:23:49.083: results -> isDisposed

    
    //Question 0: What problems can you spot here?
    
    
    func two() {
        
            var timeToKill = 0
            
            func fetchAutoCompleteItems(_ query: String) -> Observable<[String]> {
                timeToKill += 1
                return Observable.create({ (observer) -> Disposable in
                    sleep(1)
                    if timeToKill == 2 {
                        observer.onError(CustomError.someError)
                        return Disposables.create()
                    }
                    observer.onNext(["network response", query])
                    observer.onCompleted()
                    return Disposables.create()
                })
            }
            
            //Do not get idea this could be used in testing flows, we have better tools ;)
            let queryTest = Observable<String>.create { (observer) -> Disposable in
                observer.onNext("tes")
                sleep(1)
                observer.onNext("test!")
                sleep(2)
                observer.onNext("second test!")
                return Disposables.create()
            }
            
            let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            let resultCount = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            
            let results = queryTest// query.rx.text
                .debug("results")
                .throttle(1.2, scheduler: MainScheduler.instance)
                .flatMapLatest { query in
                    fetchAutoCompleteItems(query)
            }
            
            results
                .debug("resultCount")
                .map { "\($0.count)" }
                .subscribe(onNext: { (string) in
                    resultCount.text = string
                })
                .disposed(by: disposeBag)
            
            results
                .debug("textLabel")
                .map { "Hello from \($0)" }
                .subscribe(onNext: { (string) in
                    textLabel.text = string
                })
                .disposed(by: disposeBag)
        
    }
    
    //Question 0: Quess why not bind? :)
    //Question 1: What problems can you spot here?
    
    
    func three() {
        
        func fetchAutoCompleteItems(_ query: String) -> Observable<[String]> {
            return Observable.create({ (observer) -> Disposable in
                sleep(1)
                observer.onNext(["network response", query])
                observer.onCompleted()
                return Disposables.create()
            })
        }
        
        //Do not get idea this could be used in testing flows, we have better tools ;)
        let queryTest = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("tes")
            sleep(1)
            observer.onNext("test!")
            sleep(2)
            observer.onNext("second test!")
            return Disposables.create()
        }
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        let resultCount = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        
        let results = queryTest// query.rx.text
            .debug("results")
            .throttle(1.2, scheduler: MainScheduler.instance)
            .flatMapLatest { query in
                fetchAutoCompleteItems(query)
                    .observeOn(MainScheduler.instance)  // results are returned on MainScheduler
                    .catchErrorJustReturn([])  // in the worst case, errors are handled
        }.share(replay: 1)
        
        // HTTP requests are shared and results replayed
        // to all UI elements
        
        results
            .debug("resultCount")
            .map { "\($0.count)" }
            .bind(to: resultCount.rx.text)
            .disposed(by: disposeBag)
        
        results
            .debug("textLabel")
            .map { "Hello from \($0)" }
            .bind(to: textLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
//    Making sure all of these requirements are properly handled in large systems can be challenging, but there is a simpler way of using the compiler and traits to prove these requirements are met.
    
    
    func four() {
        
        func fetchAutoCompleteItems(_ query: String) -> Observable<[String]> {
            return Observable.create({ (observer) -> Disposable in
                sleep(1)
                observer.onNext(["network response", query])
                observer.onCompleted()
                return Disposables.create()
            })
        }
        
        //Do not get idea this could be used in testing flows, we have better tools ;)
        let queryTest = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("tes")
            sleep(1)
            observer.onNext("test!")
            sleep(2)
            observer.onNext("second test!")
            return Disposables.create()
        }
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        let resultCount = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        
        let results = queryTest.asDriver(onErrorJustReturn: "") // This converts a normal sequence into a `Driver` sequence.
            .debug("results")
            .throttle(1.2) // No need for adding Scheduler parameter
            .flatMapLatest { query in
                fetchAutoCompleteItems(query)
                    .asDriver(onErrorJustReturn: []) //Error handling, observeOn MainScheduler by default
            } //no need to share
        
        results
            .debug("resultCount")
            .map { "\($0.count)" }
            .drive(resultCount.rx.text) //drive instead of bind
            .disposed(by: disposeBag)
        
        results
            .debug("textLabel")
            .map { "Hello from \($0)" }
            .drive(textLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}
