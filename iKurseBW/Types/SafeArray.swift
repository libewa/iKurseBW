//
//  SafeArray.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 13.06.25.
//

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
