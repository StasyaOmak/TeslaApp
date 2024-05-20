//
//  CustomSliderView.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 15/05/2024.
//

import SwiftUI

struct CustomSliderView: View {
    
    @Binding private var value: Double
    @Binding var offset: Double
    
    @State private var lastOffset = 0.0
    @State private var previousValue = 15
    var sets: Double = 0
    private let minValue: Int
    private let maxValue: Int
    @Binding var colorOne: Color
    
    init(
        value: Binding<Double>,
        minValue: Int,
        maxValue: Int,
        offset: Binding<Double>,
        colorOne: Binding<Color>
    ) {
        _value = value
        self.minValue = minValue
        self.maxValue = maxValue
        _offset = offset
        _colorOne = colorOne
    }
    
    var body: some View {
        GeometryReader { reader in
            let maxSliderWidth = reader.size.width - 16
            
            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("Color3"), Color("Color4")]), startPoint: .top, endPoint: .bottom)
                        )
                        .frame(height: 12)
                    RoundedRectangle(cornerRadius: 25)
                        .fill(colorOne)
                        .frame(width: offset, height: 12)
                    Image("sliderIndicator")
                        .resizable()
                        .frame(width: 35, height: 25)
                        .offset(x: offset - 3, y: 0)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ dragValue in
                                    var translation = dragValue.translation.width + lastOffset
                                    translation = min(max(translation, 0), maxSliderWidth)
                                    let dragPercent = getDragPercent(translation: translation, of: maxSliderWidth)
                                        let valueNum = dragPercentToValue(dragPercent: dragPercent)
                                        value = Double(valueNum)
                                        offset = valueToFillPercent(valueNum) * maxSliderWidth
                                })
                                    
                                .onEnded({ _ in
                                    lastOffset = offset
                                })
                        )
                }
                .frame(height: 25)
            }
        }
        .frame(maxHeight: 30)
    }
    
    private func getDragPercent(translation: CGFloat, of maxWidth: CGFloat) -> CGFloat {
        translation / maxWidth
    }
    
    private func dragPercentToValue(dragPercent: CGFloat) -> Int {
        let actualValue = Int(dragPercent * Double(maxValue - minValue) + Double(minValue))
        let remainder = actualValue % step
        var roundedValue = actualValue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if remainder < step / 2 {
                roundedValue = actualValue - remainder
            } else {
                roundedValue = actualValue - remainder + step
            }
        }
        return Int(roundedValue)
    }
    
    private func valueToFillPercent(_ result: Int) -> CGFloat {
        Double(result - minValue) / Double((maxValue - minValue))
    }
    
    private let step = 1
}
