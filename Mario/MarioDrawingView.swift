//
//  ContentView.swift
//  Mario
//
//  Created by 114-2Student03 on 2026/3/15.
//

import SwiftUI

struct MarioDrawingView: View {
    private let skin = Color(red: 0.98, green: 0.84, blue: 0.70)
    private let skinShadow = Color(red: 0.93, green: 0.74, blue: 0.58)
    private let marioRed = Color(red: 0.98, green: 0.10, blue: 0.15)
    private let marioBlue = Color(red: 0.14, green: 0.33, blue: 0.76)
    private let marioBrown = Color(red: 0.45, green: 0.15, blue: 0.05)
    private let hairBrown = Color(red: 0.35, green: 0.10, blue: 0.02)
    private let shoeBrown = Color(red: 0.68, green: 0.45, blue: 0.26)
    private let outline = Color(red: 0.10, green: 0.10, blue: 0.10)

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 背景顏色
                Color(red: 0.60, green: 0.80, blue: 0.62)
                    .ignoresSafeArea()
                
                // 作業需求：加入文字
                VStack {
                    Text("MARIO")
                        .font(.system(size: 60, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: outline.opacity(0.3), radius: 5, x: 5, y: 5)
                        .padding(.top, 40)
                    
                    Spacer()
                }

                MarioFigure()
                    .frame(width: 320, height: 520)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - 50)
            }
        }
    }

    @ViewBuilder
    private func MarioFigure() -> some View {
        ZStack {
            legsAndShoes
            torsoAndArms // 這裡包含了改進後的吊帶與身體結構
            headAndHat
        }
    }

    // MARK: - 改進的部分：身體與吊帶
    private var torsoAndArms: some View {
        ZStack {
            // 1. 紅色襯衫 (解構：獨立的上身)
            RoundedRectangle(cornerRadius: 50)
                .fill(marioRed)
                .frame(width: 200, height: 160)
                .offset(y: 100)
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(outline, lineWidth: 2.2)
                        .frame(width: 200, height: 160)
                        .offset(y: 100)
                }

            // 2. 藍色吊帶 (解構：增加真實吊帶)
            // 左吊帶
            Capsule()
                .fill(marioBlue)
                .frame(width: 35, height: 120)
                .rotationEffect(.degrees(15))
                .offset(x: -45, y: 80)
                .overlay {
                    Capsule()
                        .stroke(outline, lineWidth: 2.2)
                        .frame(width: 35, height: 120)
                        .rotationEffect(.degrees(15))
                        .offset(x: -45, y: 80)
                }
            
            // 右吊帶
            Capsule()
                .fill(marioBlue)
                .frame(width: 35, height: 120)
                .rotationEffect(.degrees(-15))
                .offset(x: 45, y: 80)
                .overlay {
                    Capsule()
                        .stroke(outline, lineWidth: 2.2)
                        .frame(width: 35, height: 120)
                        .rotationEffect(.degrees(-15))
                        .offset(x: 45, y: 80)
                }

            // 3. 藍色褲身 (解構：覆蓋在襯衫上的褲子主體)
            RoundedRectangle(cornerRadius: 30)
                .fill(marioBlue)
                .frame(width: 150, height: 100)
                .offset(y: 140)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(outline, lineWidth: 2.2)
                        .frame(width: 150, height: 100)
                        .offset(y: 140)
                }

            // 4. 黃色鈕扣 (放在吊帶上)
            Circle()
                .fill(.yellow)
                .frame(width: 22, height: 22)
                .offset(x: -42, y: 125)
                .overlay {
                    Circle().stroke(outline, lineWidth: 1.8).frame(width: 22, height: 22).offset(x: -42, y: 125)
                }

            Circle()
                .fill(.yellow)
                .frame(width: 22, height: 22)
                .offset(x: 42, y: 125)
                .overlay {
                    Circle().stroke(outline, lineWidth: 1.8).frame(width: 22, height: 22).offset(x: 42, y: 125)
                }

            // 5. 手臂與手套 (延用你的結構，但微調位置)
            Group {
                // 左臂
                RoundedRectangle(cornerRadius: 24)
                    .fill(marioRed)
                    .frame(width: 50, height: 110)
                    .rotationEffect(.degrees(25))
                    .offset(x: -110, y: 110)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24).stroke(outline, lineWidth: 2.2).frame(width: 50, height: 110).rotationEffect(.degrees(25)).offset(x: -110, y: 110)
                    }
                
                // 右臂
                RoundedRectangle(cornerRadius: 24)
                    .fill(marioRed)
                    .frame(width: 50, height: 110)
                    .rotationEffect(.degrees(-25))
                    .offset(x: 110, y: 110)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24).stroke(outline, lineWidth: 2.2).frame(width: 50, height: 110).rotationEffect(.degrees(-25)).offset(x: 110, y: 110)
                    }
                
                // 手套
                GloveShape()
                    .fill(.white)
                    .frame(width: 64, height: 64)
                    .offset(x: -135, y: 165)
                    .overlay { GloveShape().stroke(outline, lineWidth: 2.0).frame(width: 64, height: 64).offset(x: -135, y: 165) }

                GloveShape()
                    .fill(.white)
                    .frame(width: 64, height: 64)
                    .scaleEffect(x: -1, y: 1)
                    .offset(x: 135, y: 165)
                    .overlay { GloveShape().stroke(outline, lineWidth: 2.0).frame(width: 64, height: 64).scaleEffect(x: -1, y: 1).offset(x: 135, y: 165) }
            }
        }
    }

    // MARK: - 原始結構保留
    private var legsAndShoes: some View {
        ZStack {
            // 左腳管
            Capsule()
                .fill(marioBlue)
                .frame(width: 70, height: 100)
                .offset(x: -45, y: 190)
                .overlay { Capsule().stroke(outline, lineWidth: 2.2).frame(width: 70, height: 100).offset(x: -45, y: 190) }
            
            // 右腳管
            Capsule()
                .fill(marioBlue)
                .frame(width: 70, height: 100)
                .offset(x: 45, y: 190)
                .overlay { Capsule().stroke(outline, lineWidth: 2.2).frame(width: 70, height: 100).offset(x: 45, y: 190) }

            // 鞋子
            Capsule().fill(shoeBrown).frame(width: 105, height: 54).rotationEffect(.degrees(-10)).offset(x: -62, y: 232)
                .overlay { Capsule().stroke(outline, lineWidth: 2.2).frame(width: 105, height: 54).rotationEffect(.degrees(-10)).offset(x: -62, y: 232) }
            Capsule().fill(shoeBrown).frame(width: 105, height: 54).rotationEffect(.degrees(10)).offset(x: 62, y: 232)
                .overlay { Capsule().stroke(outline, lineWidth: 2.2).frame(width: 105, height: 54).rotationEffect(.degrees(10)).offset(x: 62, y: 232) }
        }
    }

    private var headAndHat: some View {
        ZStack {
            // 鬢角
            Circle().fill(hairBrown).frame(width: 42, height: 64).offset(x: -66, y: -58)
            Circle().fill(hairBrown).frame(width: 42, height: 64).offset(x: 66, y: -58)
            // 耳朵
            Circle().fill(skin).frame(width: 30, height: 38).offset(x: -84, y: -37).overlay { Circle().stroke(outline, lineWidth: 2.0).frame(width: 30, height: 38).offset(x: -84, y: -37) }
            Circle().fill(skin).frame(width: 30, height: 38).offset(x: 84, y: -37).overlay { Circle().stroke(outline, lineWidth: 2.0).frame(width: 30, height: 38).offset(x: 84, y: -37) }
            // 臉部
            Ellipse().fill(skin).frame(width: 154, height: 138).offset(y: -34).overlay { Ellipse().stroke(outline, lineWidth: 2.2).frame(width: 154, height: 138).offset(y: -34) }
            // 眼睛
            Group {
                Ellipse().fill(.white).frame(width: 28, height: 38).offset(x: -26, y: -46).overlay { Ellipse().stroke(outline, lineWidth: 1.8).frame(width: 28, height: 38).offset(x: -26, y: -46) }
                Ellipse().fill(.white).frame(width: 28, height: 38).offset(x: 26, y: -46).overlay { Ellipse().stroke(outline, lineWidth: 1.8).frame(width: 28, height: 38).offset(x: 26, y: -46) }
                Ellipse().fill(Color.blue).frame(width: 12, height: 20).offset(x: -24, y: -43)
                Ellipse().fill(Color.blue).frame(width: 12, height: 20).offset(x: 24, y: -43)
                Circle().fill(.black).frame(width: 7, height: 7).offset(x: -22, y: -45)
                Circle().fill(.black).frame(width: 7, height: 7).offset(x: 22, y: -45)
            }
            // 眉毛與鬍子
            RoundedRectangle(cornerRadius: 8).fill(hairBrown).frame(width: 42, height: 12).rotationEffect(.degrees(-14)).offset(x: -25, y: -66)
            RoundedRectangle(cornerRadius: 8).fill(hairBrown).frame(width: 42, height: 12).rotationEffect(.degrees(14)).offset(x: 25, y: -66)
            Circle().fill(skinShadow).frame(width: 54, height: 50).offset(y: -16).overlay { Circle().stroke(outline, lineWidth: 2.2).frame(width: 54, height: 50).offset(y: -16) }
            MustacheShape().fill(hairBrown).frame(width: 95, height: 45).offset(y: 5).overlay { MustacheShape().stroke(outline, lineWidth: 2.0).frame(width: 95, height: 45).offset(y: 5) }
            // 嘴巴細節
            RoundedRectangle(cornerRadius: 6).fill(skin).frame(width: 42, height: 10).offset(y: 23)
            // 帽子
            Ellipse().fill(marioRed).frame(width: 170, height: 106).offset(y: -116).overlay { Ellipse().stroke(outline, lineWidth: 2.2).frame(width: 170, height: 106).offset(y: -116) }
            Capsule().fill(marioRed).frame(width: 170, height: 30).offset(y: -85).overlay { Capsule().stroke(outline, lineWidth: 2.2).frame(width: 170, height: 30).offset(y: -85) }
            Circle().fill(.white).frame(width: 52, height: 52).offset(y: -126).overlay { Circle().stroke(outline, lineWidth: 1.8).frame(width: 52, height: 52).offset(y: -126) }
            Text("M")
                .font(.system(size: 30, weight: .black, design: .rounded))
                .foregroundStyle(marioRed)
                .offset(y: -126)
                .overlay {
                    Text("M")
                        .font(.system(size: 30, weight: .black, design: .rounded))
                        .foregroundStyle(.clear)
                        .offset(y: -126)
                        .overlay {
                            Text("M")
                                .font(.system(size: 30, weight: .black, design: .rounded))
                                .foregroundStyle(.clear)
                        }
                }
        }
    }
}

// MARK: - 自定義 Shape (維持原樣)
private struct MustacheShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + rect.width * 0.08, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY * 0.95), control: CGPoint(x: rect.minX + rect.width * 0.25, y: rect.maxY * 0.98))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - rect.width * 0.08, y: rect.midY), control: CGPoint(x: rect.maxX - rect.width * 0.25, y: rect.maxY * 0.98))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY + rect.height * 0.20), control: CGPoint(x: rect.maxX - rect.width * 0.18, y: rect.minY + rect.height * 0.15))
        path.addQuadCurve(to: CGPoint(x: rect.minX + rect.width * 0.08, y: rect.midY), control: CGPoint(x: rect.minX + rect.width * 0.18, y: rect.minY + rect.height * 0.15))
        return path
    }
}

private struct GloveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + rect.width * 0.18, y: rect.maxY * 0.82))
        path.addQuadCurve(to: CGPoint(x: rect.minX + rect.width * 0.08, y: rect.minY + rect.height * 0.45), control: CGPoint(x: rect.minX + rect.width * 0.03, y: rect.maxY * 0.72))
        path.addQuadCurve(to: CGPoint(x: rect.minX + rect.width * 0.22, y: rect.minY + rect.height * 0.20), control: CGPoint(x: rect.minX + rect.width * 0.08, y: rect.minY + rect.height * 0.25))
        path.addQuadCurve(to: CGPoint(x: rect.minX + rect.width * 0.55, y: rect.minY + rect.height * 0.15), control: CGPoint(x: rect.minX + rect.width * 0.35, y: rect.minY + rect.height * 0.10))
        path.addQuadCurve(to: CGPoint(x: rect.maxX * 0.92, y: rect.minY + rect.height * 0.42), control: CGPoint(x: rect.maxX * 0.92, y: rect.minY + rect.height * 0.20))
        path.addQuadCurve(to: CGPoint(x: rect.maxX * 0.80, y: rect.maxY * 0.82), control: CGPoint(x: rect.maxX * 0.92, y: rect.maxY * 0.70))
        path.addQuadCurve(to: CGPoint(x: rect.minX + rect.width * 0.18, y: rect.maxY * 0.82), control: CGPoint(x: rect.midX, y: rect.maxY * 0.95))
        return path
    }
}

#Preview {
    MarioDrawingView()
}
