//
//  main.swift
//  BaseballGame
//
//  Created by 정재성 on 5/28/25.
//

var baseball = Baseball(
  interface: .consoleInterface,
  game: .default(interface: .consoleInterface)
)
baseball.run()
