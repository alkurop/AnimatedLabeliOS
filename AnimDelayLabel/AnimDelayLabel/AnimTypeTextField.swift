//
//  AnimTypeTextArea.swift
//  AnimDelayLabel
//
//  Created by Alexey Kuropiantnyk on 12/05/2018.
//  Copyright © 2018 Alexey Kuropiantnyk. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

public class AnimTypeTextField: UITextField {
    let millisInSeconds = 10000
    let ioScheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background)
    let mainScheduler = MainScheduler.instance
    
    var previousAnimationDisposable: Disposable?
    var currentText: String?
    
    public func setAnimatedText (text: String?, delayMicros: Int = 40, _ handle : (() -> ())? = nil) {
        
        if currentText == text { return }
        forceCompleteAnimation()
        guard let input = text else { return }
        if input.count == 0 { return }
        
        let period = Double(delayMicros) / Double(millisInSeconds)
        let letterCount = Observable<Int>.from(Array(0...input.count))
        let interval = Observable<Int>.interval(period, scheduler: ioScheduler)
        
        let processText = Observable.zip(interval, letterCount) { interval , count in String(input[0..<count]) }
        
        previousAnimationDisposable = processText
            .observeOn(mainScheduler)
            .subscribe {
                [weak self] value in
                self?.setText(value.element)
                handle?()
        }
    }
    
    func setText (_ value: String?) { if let text = value {self.text = text } }
    
    func forceCompleteAnimation() {
        previousAnimationDisposable?.dispose();
        setText(currentText)
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
