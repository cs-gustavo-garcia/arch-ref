//
//  DispatchQueueAsync.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 27/03/24.
//  Copyright © 2024 ArchrefAppOrg. All rights reserved.
//

import Foundation

public protocol DispatchQueueAsync {

    func async(group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping @convention(block) () -> Void)
    func asyncAfter(deadline: DispatchTime, qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping @Sendable @convention(block) () -> Void)
    
}

extension DispatchQueueAsync {

    func async(group: DispatchGroup? = nil, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @convention(block) () -> Void) {
        async(group: group, qos: qos, flags: flags, execute: work)
    }
    
    func asyncAfter(deadline: DispatchTime, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @Sendable @convention(block) () -> Void) {
        asyncAfter(deadline: deadline, qos: qos, flags: flags, execute: work)
    }
}

extension DispatchQueue: DispatchQueueAsync {}
