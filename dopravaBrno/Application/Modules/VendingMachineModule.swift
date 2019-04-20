//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation


class VendingMachineModule {

    public func requestVendingMachines(completion: @escaping (_: [VendingMachine]) -> ()) {
        if (hasObjectsInCache()) {
            completion(self.loadFromCache())
        } else {
            loadObjectsFromAPI(completion: completion)
        }
    }

    private func hasObjectsInCache() -> Bool {
        return loadFromCache().count > 0
    }

    private func loadObjectsFromAPI(completion: @escaping ([VendingMachine]) -> ()) {
        VendingMachinesAPI().getVendingMachines { (result) in
            do {
                let vendingMachinesObjects = try result.unwrap()
                self.saveToCache(vendingMachinesObjects)
                completion(self.loadFromCache())
            } catch {
            }
        }
    }

    private func loadFromCache() -> [VendingMachine] {
        return Database().fetch(with: VendingMachine.all)
    }

    private func saveToCache(_ vendingMachines: [VendingMachineObject]) {
        do {
            try Database().delete(type: VendingMachineObject.self)
            try Database().insertObjects(vendingMachines, update: false)
        } catch (let error) {
            print(error)
        }
    }

}