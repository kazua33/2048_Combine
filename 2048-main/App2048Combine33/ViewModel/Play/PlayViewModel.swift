//
//  PlayViewModel.swift
//  2048
//
//  Created by cmStudent on 2021/12/02.
//

import Foundation
import Combine

final class PlayViewModel: ObservableObject {
    /// play画面の数字を保管する配列
    @Published var playNumber: [[Int]] =  [[0, 0, 0, 0],
                                           [0, 0, 0, 0],
                                           [0, 0, 0, 0],
                                           [0, 0, 0, 0]]
    /// 数字が組み合わさったばかりのブロックを合体させないために使う配列
    @Published var copyPlayNumber: [[Int]] = [[],[],[],[]]
    @Published var zahyo = [1,2,3,4]
    /// 一時的に配列を保存するためのもの
    @Published var number: [[Int]] =  [[0, 0, 0, 0],
                                       [0, 0, 0, 0],
                                       [0, 0, 0, 0],
                                       [0, 0, 0, 0]]
    /// スコア
    @Published var score: Int = 0
    
    /// 画面遷移のための変数
    @Published var check = 0
    
    /// クリア時に画面表示する
    @Published var isClear = true
    /// ゲームオーバー時に画面表示する
    @Published var isGameOver = true
    
    /// ハイスコア記録
    @Published var highScore = 0
    
    /// クリア回数
    @Published var clear = 0
    
    @Published var finish = 0
    
    @Published var count = 0
    
    @Published var isTimerRunning = false
        
    @Published var cancellable: AnyCancellable?
    
    @Published var time: String?
    
    @Published var text: String!
    
    var cancellables: [Cancellable] = []
    
    init() {
        // $をつけている（状態変数として使う→今回はPublished→Publisher）
        let time = $time
            .map{ $0?.prefix(2)}
            .sink { [weak self]
            (time) in
            guard let self = self, let text = time else { return }
            
            self.text = String(text)
        }
            
        cancellables.append(time)
        
        copyPlayNumber = NumberReset()
        startRandom()
    }
    
    func stopCounting() {
        isTimerRunning = false
        cancellable?.cancel()
        resetCount()
    }
    
    func textValue(time: String) {
        self.time = time
    }
    
    func resetCount() {
        count = 0
    }
    
    
    
    /// 配列をリセットする
    func NumberReset() -> [[Int]] {
        // TODO: 色確認のため一時的に変えてます
        //        [[2, 4, 8, 16],
        //         [32, 64, 128, 256],
        //         [512, 1024, 0, 0],
        //         [0, 0, 0, 0]]
        [[0, 0, 0, 0],
         [0, 0, 0, 0],
         [0, 0, 0, 0],
         [0, 0, 0, 0]]
    }
    /// copyPlayNumberの中身をリセットする
    func copyPlayNumberReset() {
        copyPlayNumber = NumberReset()
    }
    
    
    
    /// 左にスワイプした時の処理
    func left() {
        for tate in 0..<playNumber.count {
            for yoko in 0..<playNumber[0].count {
                // 数字が存在する場合
                if playNumber[tate][yoko] != 0 {
                    var a = yoko
                    var d = 0
                    // 横の座標の位置によって処理を変える
                    switch zahyo[yoko]{
                    case 1:
                        // 何もしない
                        break
                        
                    case 2:
                        var b = 0
                        let c = yoko
                        
                        while b < 1 {
                            // 一個座標を動かす
                            a -= 1
                            // 動かした座標の先が0だった場合
                            if playNumber[tate][a] == 0{
                                // 座標の数字をそのまま代入し、前の座標の数字をゼロにする
                                playNumber[tate][a] = playNumber[tate][c]
                                playNumber[tate][c] = 0
                                // 動かした座標の先が動かす前の座標の数字と一致した場合
                            } else if playNumber[tate][a] == playNumber[tate][c] {
                                // 座標の数字を2倍にし、前の座標の数字をゼロにする
                                playNumber[tate][a] *= 2
                                playNumber[tate][c] = 0
                                // スコアを更新する
                                score += playNumber[tate][a]
                                print(score)
                                // 一度動かした数字を固定化するための処理に使う
                                copyPlayNumber[tate][a] = playNumber[tate][a]
                                d = a
                                // 上の条件が一致しなかった場合
                            } else if playNumber[tate][a] != playNumber[tate][c] {
                                // 何もしない
                            }
                            b += 1
                        } // while
                        
                    case 3:
                        var b = 0
                        var c = yoko
                        
                        while b < 2 {
                            // 一個座標を動かす
                            a -= 1
                            // 動かした座標の先が0だった場合
                            if playNumber[tate][a] == 0{
                                // 座標の数字をそのまま代入し、前の座標の数字をゼロにする
                                playNumber[tate][a] = playNumber[tate][c]
                                playNumber[tate][c] = 0
                                // 以下2個のif文はよくわからないけどこう書かないと2回以上合体するのでこう書いてます
                            } else if copyPlayNumber[tate][a] == playNumber[tate][a] {
                                break
                            } else if copyPlayNumber[tate][d] == playNumber[tate][a] {
                                break
                                // 動かした座標の先が動かす前の座標の数字と一致した場合
                            } else if playNumber[tate][a] == playNumber[tate][c] {
                                // 座標の数字を2倍にし、前の座標の数字をゼロにする
                                playNumber[tate][a] *= 2
                                playNumber[tate][c] = 0
                                score += playNumber[tate][a]
                                print(score)
                                copyPlayNumber[tate][a] = playNumber[tate][a]
                                d = a
                                // 上の条件が一致しなかった場合
                            } else if playNumber[tate][a] != playNumber[tate][c] {
                                // 何もしない
                            }
                            b += 1
                            c -= 1
                        } // while
                        
                    case 4:
                        var b = 0
                        var c = yoko
                        
                        while b < 3 {
                            a -= 1
                            if playNumber[tate][a] == 0{
                                playNumber[tate][a] = playNumber[tate][c]
                                playNumber[tate][c] = 0
                            } else if copyPlayNumber[tate][a] == playNumber[tate][a] {
                                break
                            } else if copyPlayNumber[tate][d] == playNumber[tate][a] {
                                break
                            } else if playNumber[tate][a] == playNumber[tate][c] {
                                playNumber[tate][a] *= 2
                                playNumber[tate][c] = 0
                                score += playNumber[tate][a]
                                print(score)
                                copyPlayNumber[tate][a] = playNumber[tate][a]
                                d = a
                            } else if  playNumber[tate][a] != playNumber[tate][c] {
                                break
                            }
                            b += 1
                            c -= 1
                        } // while
                        
                    default:
                        // 何もしない
                        break
                    } // switch
                } // if
            } // for yoko
        } // for tate
        copyPlayNumberReset()
    } // func left()
    
    /// 右にスワイプした時の処理
    func right() {
        for tate in 0..<playNumber.count {
            for yoko in 0..<playNumber[0].count {
                let e = 3 - yoko
                if playNumber[tate][e] != 0 {
                    var a = e
                    var d = 0
                    switch zahyo[e] {
                        // 横の座標の位置によって処理を変える
                    case 4:
                        // 何もしない
                        break
                        
                    case 3:
                        var b = 0
                        let c = e
                        while b < 1 {
                            // 一個座標を動かす
                            a += 1
                            // 動かした座標の先が0だった場合
                            if playNumber[tate][a] == 0{
                                // 座標の数字をそのまま代入し、前の座標の数字をゼロにする
                                playNumber[tate][a] = playNumber[tate][c]
                                playNumber[tate][c] = 0
                                // 動かした座標の先が動かす前の座標の数字と一致した場合
                            } else if playNumber[tate][a] == playNumber[tate][c] {
                                // 座標の数字を2倍にし、前の座標の数字をゼロにする
                                playNumber[tate][a] *= 2
                                playNumber[tate][c] = 0
                                score += playNumber[tate][a]
                                print(score)
                                // 一度動かした数字を固定化するための処理に使う
                                copyPlayNumber[tate][a] = playNumber[tate][a]
                                d = a
                                // 前の座標のaを取得しておく
                                // 上の条件が一致しなかった場合
                            } else if playNumber[tate][a] != playNumber[tate][c] {
                                // 何もしない
                            }
                            b += 1
                        } // while
                        
                    case 2:
                        var b = 0
                        var c = e
                        while b < 2 {
                            // 一個座標を動かす
                            a += 1
                            // 動かした座標の先が0だった場合
                            if playNumber[tate][a] == 0{
                                // 座標の数字をそのまま代入し、前の座標の数字をゼロにする
                                playNumber[tate][a] = playNumber[tate][c]
                                playNumber[tate][c] = 0
                            } else if copyPlayNumber[tate][a] == playNumber[tate][a] {
                                break
                            } else if copyPlayNumber[tate][d] == playNumber[tate][a] {
                                break
                                // 動かした座標の先が動かす前の座標の数字と一致した場合
                            } else if playNumber[tate][a] == playNumber[tate][c] {
                                // 座標の数字を2倍にし、前の座標の数字をゼロにする
                                playNumber[tate][a] *= 2
                                playNumber[tate][c] = 0
                                score += playNumber[tate][a]
                                print(score)
                                copyPlayNumber[tate][a] = playNumber[tate][a]
                                d = a
                                // 上の条件が一致しなかった場合
                            } else if playNumber[tate][a] != playNumber[tate][c] {
                                // 何もしない
                            }
                            b += 1
                            c += 1
                        } // while
                        
                    case 1:
                        var b = 0
                        var c = e
                        
                        while b < 3 {
                            a += 1
                            if playNumber[tate][a] == 0{
                                playNumber[tate][a] = playNumber[tate][c]
                                playNumber[tate][c] = 0
                            } else if copyPlayNumber[tate][a] == playNumber[tate][a] {
                                break
                            } else if copyPlayNumber[tate][d] == playNumber[tate][a] {
                                break
                            }else if playNumber[tate][a] == playNumber[tate][c] {
                                playNumber[tate][a] *= 2
                                playNumber[tate][c] = 0
                                score += playNumber[tate][a]
                                print(score)
                                copyPlayNumber[tate][a] = playNumber[tate][a]
                                d = a
                            } else if  playNumber[tate][a] != playNumber[tate][c] {
                                break
                            }
                            b += 1
                            c += 1
                        } // while
                        
                    default:
                        // 何もしない
                        break
                    } // switch
                } // if
            } // for yoko
        } // for tate
        copyPlayNumberReset()
    } // func right()
    
    /// 上スワイプした時の処理
    func up() {
        var before: [[Int]] = []
        var after: [[Int]] = []
        for number in 0..<4 {
            before.append(playNumber.map{
                $0[number]
            })
        }
        
        for tate in 0..<before.count {
            for yoko in 0..<before[0].count {
                // 数字が存在する場合
                if before[tate][yoko] != 0 {
                    var a = yoko
                    var d = 0
                    // 横の座標の位置によって処理を変える
                    switch zahyo[yoko]{
                    case 1:
                        // 何もしない
                        break
                        
                    case 2:
                        var b = 0
                        let c = yoko
                        while b < 1 {
                            // 一個座標を動かす
                            a -= 1
                            // 動かした座標の先が0だった場合
                            if before[tate][a] == 0{
                                // 座標の数字をそのまま代入し、前の座標の数字をゼロにする
                                before[tate][a] = before[tate][c]
                                before[tate][c] = 0
                                // 動かした座標の先が動かす前の座標の数字と一致した場合
                            } else if before[tate][a] == before[tate][c] {
                                // 座標の数字を2倍にし、前の座標の数字をゼロにする
                                before[tate][a] *= 2
                                before[tate][c] = 0
                                // スコアを更新する
                                score += before[tate][a]
                                print(score)
                                // 一度動かした数字を固定化するための処理に使う
                                copyPlayNumber[tate][a] = before[tate][a]
                                d = a
                                // 上の条件が一致しなかった場合
                            } else if before[tate][a] != before[tate][c] {
                                // 何もしない
                            }
                            b += 1
                        } // while
                        
                    case 3:
                        var b = 0
                        var c = yoko
                        while b < 2 {
                            // 一個座標を動かす
                            a -= 1
                            // 動かした座標の先が0だった場合
                            if before[tate][a] == 0{
                                // 座標の数字をそのまま代入し、前の座標の数字をゼロにする
                                before[tate][a] = before[tate][c]
                                before[tate][c] = 0
                                // 以下2個のif文はよくわからないけどこう書かないと2回以上合体するのでこう書いてます
                            } else if copyPlayNumber[tate][a] == before[tate][a] {
                                break
                            } else if copyPlayNumber[tate][d] == before[tate][a] {
                                break
                                // 動かした座標の先が動かす前の座標の数字と一致した場合
                            } else if before[tate][a] == before[tate][c] {
                                // 座標の数字を2倍にし、前の座標の数字をゼロにする
                                before[tate][a] *= 2
                                before[tate][c] = 0
                                score += before[tate][a]
                                print(score)
                                copyPlayNumber[tate][a] = before[tate][a]
                                d = a
                                // 上の条件が一致しなかった場合
                            } else if before[tate][a] != before[tate][c] {
                                // 何もしない
                            }
                            b += 1
                            c -= 1
                        } // while
                        
                    case 4:
                        var b = 0
                        var c = yoko
                        while b < 3 {
                            a -= 1
                            if before[tate][a] == 0{
                                before[tate][a] = before[tate][c]
                                before[tate][c] = 0
                            } else if copyPlayNumber[tate][a] == before[tate][a] {
                                break
                            } else if copyPlayNumber[tate][d] == before[tate][a] {
                                break
                            } else if before[tate][a] == before[tate][c] {
                                before[tate][a] *= 2
                                before[tate][c] = 0
                                score += before[tate][a]
                                print(score)
                                copyPlayNumber[tate][a] = before[tate][a]
                                d = a
                            } else if  before[tate][a] != before[tate][c] {
                                break
                            }
                            b += 1
                            c -= 1
                        } // while
                        
                    default:
                        // 何もしない
                        break
                    } // switch
                } // if
            } // for yoko
        } // for tate
        copyPlayNumberReset()
        for number in 0..<4 {
            after.append(before.map{
                $0[number]
            })
        }
        playNumber = after
        
    } // func up()
    
    /// 下スワイプした時の処理
    func down() {
        var before: [[Int]] = []
        var after: [[Int]] = []
        for number in 0..<4 {
            let v = 3 - number
            before.append(playNumber.map{
                $0[v]
            })
        }
        
        for tate in 0..<before.count {
            for yoko in 0..<before[0].count {
                let e = 3 - yoko
                if before[tate][e] != 0 {
                    var a = e
                    var d = 0
                    switch zahyo[e] {
                        // 横の座標の位置によって処理を変える
                    case 4:
                        // 何もしない
                        break
                    case 3:
                        var b = 0
                        let c = e
                        
                        while b < 1 {
                            // 一個座標を動かす
                            a += 1
                            // 動かした座標の先が0だった場合
                            if before[tate][a] == 0{
                                // 座標の数字をそのまま代入し、前の座標の数字をゼロにする
                                before[tate][a] = before[tate][c]
                                before[tate][c] = 0
                                // 動かした座標の先が動かす前の座標の数字と一致した場合
                            } else if before[tate][a] == before[tate][c] {
                                // 座標の数字を2倍にし、前の座標の数字をゼロにする
                                before[tate][a] *= 2
                                before[tate][c] = 0
                                score += before[tate][a]
                                print(score)
                                // 一度動かした数字を固定化するための処理に使う
                                copyPlayNumber[tate][a] = before[tate][a]
                                d = a
                                // 前の座標のaを取得しておく
                                // 上の条件が一致しなかった場合
                            } else if before[tate][a] != before[tate][c] {
                                // 何もしない
                            }
                            b += 1
                        } // while
                        
                    case 2:
                        var b = 0
                        var c = e
                        while b < 2 {
                            // 一個座標を動かす
                            a += 1
                            // 動かした座標の先が0だった場合
                            if before[tate][a] == 0{
                                // 座標の数字をそのまま代入し、前の座標の数字をゼロにする
                                before[tate][a] = before[tate][c]
                                before[tate][c] = 0
                            } else if copyPlayNumber[tate][a] == before[tate][a] {
                                break
                            } else if copyPlayNumber[tate][d] == before[tate][a] {
                                break
                                // 動かした座標の先が動かす前の座標の数字と一致した場合
                            } else if before[tate][a] == before[tate][c] {
                                // 座標の数字を2倍にし、前の座標の数字をゼロにする
                                before[tate][a] *= 2
                                before[tate][c] = 0
                                score += before[tate][a]
                                print(score)
                                copyPlayNumber[tate][a] = before[tate][a]
                                d = a
                                // 上の条件が一致しなかった場合
                            } else if before[tate][a] != before[tate][c] {
                                // 何もしない
                            }
                            b += 1
                            c += 1
                        } // while
                        
                    case 1:
                        var b = 0
                        var c = e
                        while b < 3 {
                            a += 1
                            if before[tate][a] == 0{
                                before[tate][a] = before[tate][c]
                                before[tate][c] = 0
                            } else if copyPlayNumber[tate][a] == before[tate][a] {
                                break
                            } else if copyPlayNumber[tate][d] == before[tate][a] {
                                break
                            }else if before[tate][a] == before[tate][c] {
                                before[tate][a] *= 2
                                before[tate][c] = 0
                                score += before[tate][a]
                                print(score)
                                copyPlayNumber[tate][a] = before[tate][a]
                                d = a
                            } else if  before[tate][a] != before[tate][c] {
                                break
                            }
                            b += 1
                            c += 1
                        } // while
                        
                    default:
                        // 何もしない
                        break
                    } // switch
                } // if
            } // for yoko
        } // for tate
        
        print("before\(before)")
        copyPlayNumberReset()
        
        for number in 0..<4{
            after.append(before.map{
                $0[number]
            })
            after[number].reverse()
        }
        playNumber = after
    } // func down()
    
    /// ランダムで数字を出現させる
    func randomNumber() {
        var randomTate = 0
        var randomYoko = 0
        var randomNumber = 0
        while (true) {
            randomTate = Int.random(in: 0..<4)
            randomYoko = Int.random(in: 0..<4)
            if playNumber[randomTate][randomYoko] == 0 {
                randomNumber = Int.random(in: 0..<5)
                switch randomNumber {
                case 0,1,2:
                    playNumber[randomTate][randomYoko] = 2
                    
                case 3,4:
                    playNumber[randomTate][randomYoko] = 4
                    
                default:
                    break
                }
                break
            } // if
        } // while
    } // func randomNumber
    
    ///　スタート時にランダムで2個数字を出現させる
    func startRandom() {
        var randomTate = 0
        var randomYoko = 0
        var randomNumber = 0
        while (true) {
            randomTate = Int.random(in: 0..<4)
            randomYoko = Int.random(in: 0..<4)
            if playNumber[randomTate][randomYoko] == 0 {
                randomNumber = Int.random(in: 0..<5)
                switch randomNumber {
                case 0,1,2:
                    playNumber[randomTate][randomYoko] = 2
                    
                case 3,4:
                    playNumber[randomTate][randomYoko] = 4
                    
                default:
                    break
                }
                break
            } // if
        } // while
        while (true) {
            randomTate = Int.random(in: 0..<4)
            randomYoko = Int.random(in: 0..<4)
            if playNumber[randomTate][randomYoko] == 0 {
                randomNumber = Int.random(in: 0..<5)
                switch randomNumber {
                case 0,1,2:
                    playNumber[randomTate][randomYoko] = 2
                    
                case 3,4:
                    playNumber[randomTate][randomYoko] = 4
                    
                default:
                    break
                }
                break
            } // if
        } // while
    } // func startRandom
    
    /// 左スワイプした時に動いたらランダムで数字を出現させる処理
    func LeftSwipe() {
        // 一旦今ある配列を保存する
        number = playNumber
        
        left()
        
        // もし保存したNumberとplayNumberが違うなら数字をランダムに出現させる
        if number != playNumber {
            randomNumber()
        } // if
    } // func LeftSwipe
    
    /// 右スワイプした時に動いたらランダムで数字を出現させる処理
    func RightSwipe() {
        // 一旦今ある配列を保存する
        number = playNumber
        
        right()
        
        // もし保存したNumberとplayNumberが違うなら数字をランダムに出現させる
        if number != playNumber {
            randomNumber()
        } // if
    } // func RightSwipe
    
    /// 上スワイプした時に動いたらランダムで数字を出現させる処理
    func UpSwipe() {
        // 一旦今ある配列を保存する
        number = playNumber
        
        up()
        
        // もし保存したNumberとplayNumberが違うなら数字をランダムに出現させる
        if number != playNumber {
            randomNumber()
        } // if
    } // func UpSwipe
    
    /// 下スワイプした時に動いたらランダムで数字を出現させる処理
    func DownSwipe() {
        // 一旦今ある配列を保存する
        number = playNumber
        
        down()
        
        // もし保存したNumberとplayNumberが違うなら数字をランダムに出現させる
        if number != playNumber {
            randomNumber()
        } // if
    } // funcDownSwipe
    
    // クリア画面を表示させる処理
    func Clear() {
        var clearNumber = 0
        // 全部の数字がある時だけ実行するようにする
        for tate in 0..<playNumber.count {
            for yoko in 0..<playNumber[0].count {
                // もし2048であれば1足す
                if playNumber[tate][yoko] == 2048 {
                    clearNumber += 1
                }
            }
        }
        // 0が一つもなければ実行する
        if clearNumber > 0 {
            
            finish = 1
            
        } // if
    }
    // ゲームオーバーさせるのに必要な処理
    func gameover() {
        var notZero = 0
        // 全部の数字がある時だけ実行するようにする
        for tate in 0..<playNumber.count {
            for yoko in 0..<playNumber[0].count {
                // もし0であれば1足す
                if playNumber[tate][yoko] == 0 {
                    notZero += 1
                }
            }
        }
        // 0が一つもなければ実行する
        if notZero == 0 {
            // 一旦今ある配列とスコアを保存する
            number = playNumber
            let playScore = score
            // 全方向のスワイプを試す
            left()
            right()
            up()
            down()
            // もし保存したNumberとplayNumberが一致したらゲームオーバー
            if number == playNumber {
                check = 2
            } else { // そうでなければ元の数字に戻す
                playNumber = number
                score = playScore
            } // if
        } // if
    } // func gemeover
    
    /// ゲームオーバー0の後続ける場合の処理
    func replay(highscore: Int, Score: Int) -> Int {
        if highscore < Score {
            highScore = Score
            UserDefaults.standard.set(highScore, forKey: "Numeric")
        }
        score = 0
        check = 0
        return highScore
    }
    
    
} // class PlayViewModel
