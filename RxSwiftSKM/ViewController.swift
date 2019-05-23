//
//  ViewController.swift
//  RxSwiftSKM
//
//  Created by Kamil Buczel on 18/05/2019.
//  Copyright © 2019 Kamajabu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exampleOne = ExampleOne()
        let exampleTwo = ExampleTwo()
        let exampleThree = ExampleThree()
        let exampleFour = ExampleFour()
        let exampleFive = ExampleFive()
        let exampleSix = ExampleSix()
        let exampleSeven = ExampleSeven()
        let exampleEight = ExampleEight()

        exampleOne.start()
        exampleTwo.start()
        exampleThree.start()
        exampleFour.start()
        exampleFive.start()
        exampleEight.start()
//        exampleFour.start()
//        exampleFive.start()
        //ExampleOne().First()
        //ExampleOne().Second()
//        ExampleOne().third()
//        exampleOne.four()
//        ExampleOne().five()



    }


}

func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

