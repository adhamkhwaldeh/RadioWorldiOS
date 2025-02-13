//
//  BaseDao.swift
//  protv
//
//  Created by adham khwaldeh on 11/1/20.
//  Copyright © 2020 adham khwaldeh. All rights reserved.
//

import Foundation
import GRDB
import Combine

class BaseDao<T> where T: Codable, T: FetchableRecord, T: MutablePersistableRecord {

    let database: DatabaseWriter
    
    let dbQueue: DatabaseQueue
    
    let dbPool: DatabasePool

    init(database: DatabaseWriter,dbQueue: DatabaseQueue, dbPool: DatabasePool) {
        self.database = database
        self.dbQueue = dbQueue
        self.dbPool = dbPool
    }

    /*Load channels list started*/
    func observeAll() -> AnyPublisher<[T],Error> {
       return dbQueue.readPublisher{ db in
            try T.fetchAll(db)
       }.eraseToAnyPublisher()
//        dbQueue.rx.read(db in try T.fetchAll(db))
//        T.fetchAll(database).rx
//        (database.rx.read(value:
//            try T.fetchAll(database)
//        )//(database)//.rx.observeAll(in: database)
    }

    func observeQueryList(_ request: QueryInterfaceRequest<T>) -> AnyPublisher<[T],Error> {
        return dbQueue.readPublisher { db in try T.fetchAll(db) }.eraseToAnyPublisher()
    }

//    func observeQueryOne(_ request: QueryInterfaceRequest<T>) -> Single<T?> {
//        return request.rx.observeFirst(in: database)
//    }
    
    func observeQueryOne(_ request: QueryInterfaceRequest<T>) -> AnyPublisher<T?,Error> {
        return dbQueue.readPublisher { db in
            try T.fetchOne(db,request)
        }.eraseToAnyPublisher()
    }
    /*Load channels list ended*/



    /*Delete channel operation started*/
    func deleteAll() -> AnyPublisher<Void,Error> {
        return database.writePublisher{ db in try T.deleteAll(db)}.eraseToAnyPublisher()
    }

    func deleteOne(_ poJo: T) -> AnyPublisher<Void,Error>  {
        return database.writePublisher { db in
            try poJo.delete(db)
        }.eraseToAnyPublisher()
    }
    /*Delete channel operation started*/


    /*Insert one started*/
    func insertOne(poJo: T) -> AnyPublisher<Void,Error>  {
//        return database.writePublisher { db in
//            var tmp = poJo
//            try tmp.insert(db)
//        }.eraseToAnyPublisher()
        return dbQueue.writePublisher { db in
            var tmp = poJo
            try tmp.insert(db)
//            try T.insert(poJo)//(db,request)
        }.eraseToAnyPublisher()
    }
    /*Insert one started*/


}
