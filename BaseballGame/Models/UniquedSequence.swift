//
//  UniquedSequence.swift
//  BaseballGame
//
//  Created by 정재성 on 5/28/25.
//

extension Sequence where Element: Hashable {
  func uniqued() -> UniquedSequence<Self> {
    UniquedSequence(base: self)
  }
}

// MARK: - UniquedSequence

struct UniquedSequence<Base: Sequence> where Base.Element: Hashable {
  let base: Base

  init(base: Base) {
    self.base = base
  }
}

// MARK: - UniquedSequence (Sequence)

extension UniquedSequence: Sequence {
  struct Iterator: IteratorProtocol {
    var base: Base.Iterator
    var seen: Set<Base.Element> = []

    init(base: Base.Iterator) {
      self.base = base
    }

    mutating func next() -> Base.Element? {
      while let element = base.next() {
        if seen.insert(element).inserted {
          return element
        }
      }
      return nil
    }
  }

  func makeIterator() -> Iterator {
    Iterator(base: base.makeIterator())
  }
}
