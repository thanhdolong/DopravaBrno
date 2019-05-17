//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

class StopsModule: BaseDataModule<StopObject, Stop> {

    required init() {
        super.init(fetchRequest: Stop.all)
    }

    public func requestStops(completion: @escaping (_: [Stop]) -> Void) {
        loadObjectsFromAPI(completion: { _ in })
        if hasObjectsInCache() {
            completion(self.loadFromCache())
        } else {
            loadObjectsFromAPI(completion: completion)
        }
    }

    private func loadObjectsFromAPI(completion: @escaping ([Stop]) -> Void) {
        IdsJmkAPI().getStops { (result) in
            do {
                let stopsObject = try result.unwrap()
                self.saveToCache(stopsObject)
                completion(self.loadFromCache())
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
}
