//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Unbox

class VehiclesModule: BaseDataModule<VehicleObject, Vehicle> {

    required init() {
        super.init(fetchRequest: Vehicle.all)
    }

    public func requestVehicles(completion: @escaping (_: [Vehicle]) -> Void) {
        loadObjectsFromAPI(completion: completion)
    }

    private func loadObjectsFromAPI(completion: @escaping ([Vehicle]) -> Void) {
        IdsJmkAPI().getVehicles { (result) in
            do {
                let vehicleObjects = try result.unwrap(atKey: "Vehicles")
                self.saveToCache(vehicleObjects)
                completion(self.loadFromCache())
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
}
