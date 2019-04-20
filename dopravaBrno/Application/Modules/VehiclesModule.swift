//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

class VehiclesModule {

    public func requestVehicles(completion: @escaping (_: [Vehicle]) -> ()) {
        loadObjectsFromAPI(completion: completion)
    }


    private func loadObjectsFromAPI(completion: @escaping ([Vehicle]) -> ()) {
        SotorisAPI().getVehicles { (result) in
            do {
                let vehicleObjects = try result.unwrap()
                self.saveToCache(vehicleObjects)
                completion(self.loadFromCache())
            } catch {
            }
        }
    }

    private func loadFromCache() -> [Vehicle] {
        return Database().fetch(with: Vehicle.all)
    }

    private func saveToCache(_ vehicles: [VehicleObject]) {
        do {
            try Database().delete(type: VehicleObject.self)
            try Database().insertObjects(vehicles, update: false)
        } catch (let error) {
            print(error)
        }
    }
}