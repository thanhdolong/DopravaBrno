//
//  MulticastDelegate.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 25/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

public class MulticastDelegate<ProtocolType> {
    private class DelegateWrapper {
        weak var delegate: AnyObject?
        
        init(_ delegate: AnyObject) {
            self.delegate = delegate
        }
    }
    
    private var delegateWrapper: [DelegateWrapper]
    
    public var delegates: [ProtocolType] {
        delegateWrapper = delegateWrapper.filter({ $0.delegate != nil })
        return delegateWrapper.map({ $0.delegate! }) as! [ProtocolType]
    }
    
    public init(delegates: [ProtocolType] = []) {
        delegateWrapper = delegates.map {
            DelegateWrapper($0 as AnyObject)
        }
    }
    
    public func addDelegate(_ delegate: ProtocolType) {
        let wrapper = DelegateWrapper(delegate as AnyObject)
        delegateWrapper.append(wrapper)
    }
    
    public func removeDelegate(_ delegate: ProtocolType) {
        guard let index = delegateWrapper.firstIndex(where: {$0.delegate === (delegate as AnyObject)}) else {
            return
        }
        
        delegateWrapper.remove(at: index)
    }
    
    public func invokeDelegates(_ closure: (ProtocolType) -> Void) {
        delegates.forEach({ closure($0) })
    }
}
