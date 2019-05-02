//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

class VendingMachineModule: BaseDataModule<VendingMachineObject, VendingMachine> {

    required init() {
        super.init(fetchRequest: VendingMachine.all)
    }

    public func requestVendingMachines(completion: @escaping (_: [VendingMachine]) -> Void) {
        if hasObjectsInCache() {
            completion(self.loadFromCache())
        } else {
            loadObjectsFromAPI(completion: completion)
        }
    }

    private func loadObjectsFromAPI(completion: @escaping ([VendingMachine]) -> Void) {
        VendingMachinesAPI().getVendingMachines { (result) in
            do {
                let vendingMachinesObjects = try result.unwrap()
                self.saveToCache(vendingMachinesObjects)
                completion(self.loadFromCache())
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
}
