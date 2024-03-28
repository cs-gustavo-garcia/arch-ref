//
//  DispatchQueueAsyncFake.swift
//  ArchrefAppTests
//
//  Created by gustavo.garcia.leite on 27/03/24.
//  Copyright © 2024 ArchrefAppOrg. All rights reserved.
//

@testable import ArchrefApp
import Foundation

final class DispatchQueueAsyncFake: DispatchQueueAsync {

    init() { }

    func async(group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping @convention(block) () -> Void) {
        work()
    }

    func asyncAfter(deadline: DispatchTime, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @Sendable @convention(block) () -> Void) {
        work()
    }
}
