//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

class StopsModule {

    public func requestStops(completion: @escaping (_: [Stop]) -> ()) {
        if (hasObjectsInCache()) {
            completion(self.loadFromCache())
        } else {
            loadObjectsFromAPI(completion: completion)
        }
    }

    private func hasObjectsInCache() -> Bool {
        return loadFromCache().count > 0
    }

    private func loadObjectsFromAPI(completion: @escaping ([Stop]) -> ()) {
        IdsJmkAPI().getStops { (result) in
            do {
                let stopsObject = try result.unwrap()
                self.saveToCache(stopsObject)
                completion(self.loadFromCache())
            } catch {
            }
        }
    }

    private func loadFromCache() -> [Stop] {
        return Database().fetch(with: Stop.all)
    }

    private func saveToCache(_ stops: [StopObject]) {
        do {
            try Database().delete(type: StopObject.self)
            try Database().insertObjects(stops, update: false)
        } catch (let error) {
            print(error)
        }
    }
}
