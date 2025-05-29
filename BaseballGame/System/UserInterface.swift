//
//  UserInterface.swift
//  BaseballGame
//
//  Created by 정재성 on 5/28/25.
//

import Foundation

struct UserInterface {
  let readMenu: () -> Menu
  let readNumbers: () -> [Int]

  let showStartMessage: () -> Void
  let showResult: (Int, Int) -> Void
  let showSuccess: () -> Void
  let showRecords: ([Record]) -> Void
  let showQuitMessage: () -> Void

  static let consoleInterface = UserInterface {
    print(
      """
      환영합니다! 원하시는 번호를 입력해주세요
      1. 게임 시작하기    2. 게임 기록 보기    3. 종료하기
      """
    )
    repeat {
      if let menu = readLine().flatMap(Int.init).flatMap(Menu.init) {
        return menu
      }
      print("잘못 된 입력입니다.")
    } while true
  } readNumbers: {
    repeat {
      print("숫자를 입력하세요")
      let inputNumbers = readLine()
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .flatMap { text in
          let uniquedNumbers = text
            .map(String.init)
            .compactMap(Int.init)
            .filter { $0 > 0 }
            .uniqued()
          let numbers = Array(uniquedNumbers)
          return numbers.count >= 3 ? numbers : nil
        }
      if let inputNumbers {
        return inputNumbers
      } else {
        print("올바르지 않은 입력값입니다")
      }
    } while true
  } showStartMessage: {
    print("< 게임을 시작합니다 >")
  } showResult: { strike, ball in
    if strike > 0 || ball > 0 {
      let messages = [
        strike > 0 ? "\(strike)스트라이크" : nil,
        ball > 0 ? "\(ball)볼" : nil
      ]
      print(messages.compactMap { $0 }.joined(separator: " "))
    } else {
      print("Nothing")
    }
  } showSuccess: {
    print("정답입니다!")
  } showRecords: { records in
    print("< 게임 기록 보기 >")
    print(records.map { "\($0.order)번째 게임 : 시도 횟수 - \($0.tryCount)" }.joined(separator: "\n"))
  } showQuitMessage: {
    print("< 숫자 야구 게임을 종료합니다 >")
  }
}
