//
// Created by Alexey Kuropiantnyk on 21/05/2018.
// Copyright (c) 2018 Alexey Kuropiantnyk. All rights reserved.
//

import Foundation
import RxSwift

class TextAnimator {
    let millisInSeconds = 10000
    let animationPublisher = PublishSubject<String>()
    let ioScheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background)

    func animate(input: String, delayMicros: Int) -> Observable<String> {

        let period = Double(delayMicros) / Double(millisInSeconds)
        let letterCount = Observable<Int>.from(Array(0...input.count))
        let interval = Observable<Int>.interval(period, scheduler: ioScheduler)
        return Observable.zip(interval, letterCount) { interval, count in String(input[0..<count]) }
    }

}