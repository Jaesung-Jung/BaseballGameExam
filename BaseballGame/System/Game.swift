//
//  Game.swift
//  BaseballGame
//
//  Created by 정재성 on 5/28/25.
//

struct Game {
  let start: () -> Int

  static func `default`(interface: UserInterface) -> Game {
    Game {
      let rule = Rule()
      let answer = rule.generateAnswer()
      var tryCount = 0

      interface.showStartMessage()
      repeat {
        let numbers = interface.readNumbers()
        let result = rule.checkNumbers(answer: answer, numbers: numbers)
        guard result.strike != numbers.count else {
          interface.showSuccess()
          return tryCount
        }
        tryCount += 1
        interface.showResult(result.strike, result.ball)
      } while true
    }
  }
}

// MARK: - Game.Rule

extension Game {
  struct Rule {
    func generateAnswer() -> some RandomAccessCollection<Int> {
      let firstNumber = Int.random(in: 1...9)
      return [[firstNumber], (0...9).filter { $0 != firstNumber }.shuffled().prefix(2)].flatMap { $0 }
    }

    func checkNumbers<A: RandomAccessCollection<Int>, N: RandomAccessCollection<Int>>(answer: A, numbers: N) -> (strike: Int, ball: Int) {
      let indexBy: (Int) -> N.Index = { numbers.index(numbers.startIndex, offsetBy: $0) }
      return answer.enumerated().reduce(into: (strike: 0, ball: 0)) { result, item in
        if numbers[indexBy(item.offset)] == item.element {
          result.strike += 1
        } else if numbers[indexBy((item.offset + 1) % answer.count)] == item.element || numbers[indexBy((item.offset + 2) % answer.count)] == item.element {
          result.ball += 1
        }
      }
    }
  }
}
