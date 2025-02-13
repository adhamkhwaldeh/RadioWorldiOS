//
//  ObservedObjectExtensions.swift
//  radiostore
//
//  Created by adham khwaldeh on 9/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import SwiftUI

extension ObservedObject.Wrapper {
    var readOnly: ReadOnly {
        // FIXME: ⚠️ Replace it with a safe implementation!!
        return ReadOnly(unsafeBitCast(self, to: ObjectType.self))
    }

    @dynamicMemberLookup
    struct ReadOnly {
        private let object: ObjectType

        init(_ object: ObjectType) {
            self.object = object
        }

        subscript<Subject>(dynamicMember keyPath: KeyPath<ObjectType, Subject>) -> Binding<Subject> {
            Binding<Subject>(
                get: { self.object[keyPath: keyPath] },
                set: { _ in assertionFailure("Read-only") }
            )
        }
    }
}
