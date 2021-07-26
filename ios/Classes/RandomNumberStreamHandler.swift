//
//  RandomNumberStreamHandler.swift
//  batterylevel
//
//  Created by 陳耀奇 on 2021/7/26.
//

import Foundation
import Flutter

class RandomNumberStreamHandler: NSObject, FlutterStreamHandler{
    var sink: FlutterEventSink?
    var timer: Timer?
    
    @objc func sendNewRandomNumber() {
        guard let sink = sink else { return }
        
        let randomNumber = Int.random(in: 1..<7)
        sink(randomNumber)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendNewRandomNumber), userInfo: nil, repeats: true)
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        timer?.invalidate()
        return nil
    }
}
