//
//  IMapper.swift
//  radiostore
//
//  Created by adham khwaldeh on 29/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation


protocol IMapper {
    func transform<T,E>(poJo:T) -> E
}
