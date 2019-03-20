//
//  FetchRequest.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 20/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

import Foundation
import RealmSwift

struct FetchRequest<Model, RealmObject: Object> {
    let predicate: NSPredicate?
    let sortDescriptors: [SortDescriptor]
    let transformer: (Results<RealmObject>) -> Model
}
