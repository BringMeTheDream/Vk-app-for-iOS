//
//  OperationManager.swift
//  vk
//
//  Created by Андрей Коноплев on 28.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

class OperationManager {
    private static var operationQueue = OperationQueue()
    
    static func addOperation(operation: Operation, cancelQueue: Bool) {
        operationQueue.maxConcurrentOperationCount = 1
        if cancelQueue {
            operationQueue.cancelAllOperations()
        }
        operationQueue.addOperation(operation)
    }
}
