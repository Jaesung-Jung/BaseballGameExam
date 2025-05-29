//
//  Baseball.swift
//  BaseballGame
//
//  Created by 정재성 on 5/28/25.
//

struct Baseball {
  private let interface: UserInterface
  private let game: Game
  private var records: [Record] = []

  init(interface: UserInterface, game: Game, records: [Record] = []) {
    self.interface = interface
    self.game = game
    self.records = records
  }

  mutating func run() {
    var menu: Menu
    repeat {
      menu = interface.readMenu()
      switch menu {
      case .startGame:
        let tryCount = game.start()
        let newRecord = Record(order: records.count + 1, tryCount: tryCount)
        records.append(newRecord)
      case .showRecords:
        interface.showRecords(records)
      case .quit:
        interface.showQuitMessage()
      }
    } while menu != .quit
  }
}
