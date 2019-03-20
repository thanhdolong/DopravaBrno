//
//  DatabaseManager.swift
//  challenge
//
//  Created by Thành Đỗ Long on 08/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit
import RealmSwift

enum DatabaseError: Error {
    case updaDataError
    case saveDataError
    case deleteDataError
}

final class Database {
    
    private let realm: Realm
    init(realm: Realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))) {
        self.realm = realm
    }
    
    //    Update method
    
    func update<RealmObject: Object>(type: RealmObject.Type, where predicate: NSPredicate?, setValues values: [String:Any?]) throws -> Void {
        do {
            try realm.write {
                var results = realm.objects(type)
                
                if let predicate = predicate {
                    results = results.filter(predicate)
                }
                
                for (forKey, value) in values {
                    results.setValue(value, forKey: forKey)
                }
            }
        } catch (let error) {
            print(error)
            throw DatabaseError.updaDataError
        }
        
    }
    
    //    Insert method
    
    func insertObjects(_ objects: [Object], update: Bool) throws {
        do {
            try realm.write {
                realm.add(objects, update: update)
            }
        } catch (let error) {
            print(error)
            throw DatabaseError.saveDataError
        }
    }
    
    func insertOrUpdate<Model, RealmObject: Object>(model: Model, with reverseTransformer: (Model) -> RealmObject) throws {
        do {
            let object = reverseTransformer(model)
            try realm.write {
                realm.add(object, update: true)
            }
        } catch (let error) {
            print(error)
            throw DatabaseError.saveDataError
        }
    }
    
    //    Fetch method
    
    func fetch<Model, RealmObject: Object>(with request: FetchRequest<Model, RealmObject>) -> Model {
        var results =  realm.objects(RealmObject.self)
        
        if let predicate = request.predicate {
            results = results.filter(predicate)
        }
        
        if request.sortDescriptors.count > 0 {
            results = results.sorted(by: request.sortDescriptors)
        }
        
        return request.transformer(results)
        
    }
    
    
    func fetch<Model, RealmObject: Object>(where predicate: NSPredicate?, sortDescriptors: [SortDescriptor]?, transformer: (Results<RealmObject>) -> Model) -> Model {
        var results = realm.objects(RealmObject.self)
        
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        
        if let sortDescriptors = sortDescriptors, sortDescriptors.count > 0 {
            results = results.sorted(by: sortDescriptors)
        }
        
        return transformer(results)
    }
    
    
    //    Delete method
    func delete<RealmObject: Object>(type: RealmObject.Type, with primaryKey: String) throws {
        do {
            let object = realm.object(ofType: type, forPrimaryKey: primaryKey)
            if let object = object {
                try realm.write {
                    realm.delete(object)
                }
            }
        } catch (let error) {
            print(error)
            throw DatabaseError.deleteDataError
        }
    }
    
    func delete<RealmObject: Object>(type: RealmObject.Type, where predicate: NSPredicate?) throws {
        do {
            try realm.write {
                var results = realm.objects(type)
                
                if let predicate = predicate {
                    results = results.filter(predicate)
                }
                
                realm.delete(results)
            }
        } catch (let error) {
            print(error)
            throw DatabaseError.deleteDataError
        }
    }
    
    func delete<RealmObject: Object>(type: RealmObject.Type) throws {
        do {
            try realm.write {
                let results = realm.objects(type)
                realm.delete(results)
            }
        } catch (let error) {
            print(error)
            throw DatabaseError.deleteDataError
        }
    }
    
    
    func deleteAllFromDatabase() throws {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch (let error) {
            print(error)
            throw DatabaseError.deleteDataError
        }
    }
}
