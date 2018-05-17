//
//  AnimTypeTextView.swift
//  AnimDelayLabel
//
//  Created by Alexey Kuropiantnyk on 12/05/2018.
//  Copyright © 2018 Alexey Kuropiantnyk. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

public class AnimTypeTextView: UITextView {
    let millisInSeconds = 10000
    let ioScheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background)
    let mainScheduler = MainScheduler.instance
    
    var previousAnimationDisposable: Disposable?
    var currentText: String?
    
    public func setAnimatedText (text: String?, delayMicros: Int = 7, _ handle : (() -> ())? = nil) {
        
        if currentText == text { return }
        forceCompleteAnimation()
        currentText = text
        guard let input = text else { return }
        if input.count == 0 { return }
        
        let period = Double(delayMicros) / Double(millisInSeconds)
        let letterCount = Observable<Int>.from(Array(0...input.count))
        let interval = Observable<Int>.interval(period, scheduler: ioScheduler)
        
        let processText = Observable.zip(interval, letterCount) { interval , count in String(input[0..<count]) }
        
        previousAnimationDisposable = processText
            .observeOn(mainScheduler)
            .subscribe(onNext: { [weak self] text in
                self?.text = text
                handle?()
            })
    }
    
    func forceCompleteAnimation() {
        previousAnimationDisposable?.dispose();
        self.text = currentText
    }
    
    override public func willMove(toWindow newWindow: UIWindow?) {
        forceCompleteAnimation()
        super.willMove(toWindow: newWindow)
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        forceCompleteAnimation()
        super.willMove(toSuperview: newSuperview)
    }
}
