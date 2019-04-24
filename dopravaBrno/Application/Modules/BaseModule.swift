//
// Created by Michal Mrnustik on 2019-04-20.
// Copyright (c) 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import RealmSwift

class BaseDataModule<TObject: Object, TModel> {
    var fetchRequest: FetchRequest<[TModel], TObject>

    init(fetchRequest: FetchRequest<[TModel], TObject>) {
        self.fetchRequest = fetchRequest
    }

    func hasObjectsInCache() -> Bool {
        return loadFromCache().count > 0
    }

    func loadFromCache() -> [TModel] {
        return Database().fetch(with: fetchRequest)
    }

    func saveToCache(_ objects: [TObject]) {
        do {
            try Database().delete(type: TObject.self)
            try Database().insertObjects(objects, update: false)
        } catch let error {
            print(error)
        }
    }

}
