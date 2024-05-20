//
//  ClimateView.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 14/05/2024.
//

import SwiftUI

struct ClimateView: View {
    
    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.background)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundStackView {
                    
                    VStack {
                        HStack(spacing: 30) {
                            backButton
                            textLabel
                            settingButton
                        }
                        .frame(height: 200)
                        
                        systemScreen
                        climateButton
                            .position(x: UIScreen.main.bounds.width / 2, y: 50)
                    }
                    .padding(.bottom)
                }
                .frame(height: UIScreen.main.bounds.height)
                bottomSheetView
                    .frame(height: UIScreen.main.bounds.height + 250)
                    .background(RoundedRectangle(cornerRadius: 40).fill(.lockButtonGradientBottom))
                    .ignoresSafeArea(.all, edges: .bottom)
                    .offset(y: UIScreen.main.bounds.height)
                    .offset(y: currentSettingsOffsetY)
                    .gesture(dragGesture)
                if isAllertShow {
                    alertView
                        .transition(.slide)
                        .zIndex(1)
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    @State private var conditionerValue: Double = 15.0
    @State private var isConditionerOn: Bool = false
    @State private var isExpanded = true
    @State private var acOffset = 0.0
    @State private var increasingColor = Color.topDradient
    @State private var fanOffset = 0.0
    @State private var fanValue: Double = 0.0
    @State private var heatOffset = 0.0
    @State private var heatValue: Double = 0.0
    @State private var autoOffset = 0.0
    @State private var autoValue: Double = 0.0
    @State var startColor = Color.topDradient
    @State var endColor = Color.yellow
    @GestureState private var gestureOffset = CGSize.zero
    
    @State private var currentSettingsOffsetY: CGFloat = 0.0
    @State private var lastSettingsOffsetY: CGFloat = 0.0
    @Environment(\.dismiss) private var dismiss
    @State private var sliderValue = 15
    @State private var selectedColor = Color.topDradient
    
    @State var isAllertShow = false
    
    private var bottomSheetView: some View {
        VStack {
            bottomSheetHeaderView
            controlButtonsView
            Spacer()
        }
    }
    
    var settingButton: some View {
        Button {
            withAnimation {
                isAllertShow.toggle()
            }
        } label: {
            Image(systemName: "gearshape")
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .tint(.gray)
                .neumorphismUNSelectedCircle()
                .neumorphismUnSelectedStyle()
        }
    }
    
    var alertView: some View {
        VStack(spacing: 20){
            Text("Tesla Support")
                .foregroundColor(.white)
                .font(.title)
            if let url = URL(string: "https://www.tesla.com/support") {
                Link("Click on me", destination: url)
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.top)
            }
            Button("Cancel")  {
                withAnimation {
                    isAllertShow.toggle()
                }
            }
            .foregroundColor(.red)
        }
        .padding(35)
        .background(RoundedRectangle(cornerRadius: 20).fill(.circleButtonGradientBottom))
        .frame(width: 300, height: 200)
        .padding(.top, 100)
        .shadow(radius: 15)
    }
    
    var backButton: some View {
        NavigationLink {
            MainTabView()
        } label: {
            Image(systemName: "chevron.left")
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .tint(.gray)
                .neumorphismUNSelectedCircle()
                .neumorphismUnSelectedStyle()
        }
    }
    
    var textLabel: some View {
        Text("CLIMATE")
            .fontWeight(.bold)
            .font(.title)
        
    }
    
    var systemScreen: some View {
        
        ZStack {
            Circle()
                .trim(from: 0.0, to: CGFloat((conditionerValue - 15) / 15))
                .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .round))
                .foregroundColor(selectedColor)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 160, height: 160)
                .zIndex(1)
                .opacity(isConditionerOn ? 1 : 0)
                .shadow(color: conditionerValue < 24 ? selectedColor : .yellow, radius: 10, x: 0, y: 0)
            Circle()
                .fill(.lightShadow)
                .frame(width: 185, height: 185)
                .climateCircleSystemIndicator()
            if #available(iOS 16.0, *) {
                Circle()
                    .fill(
                        .darkShadow
                            .shadow(.inner(color: .circleButtonGradientTop.opacity(0.7), radius: 60, x: -60, y: -60))
                    )
                    .overlay {
                        Text("\(conditionerValue.description.prefix(2))° C")
                            .font(.system(size: 30, weight: .bold))
                            .opacity(isConditionerOn ? 1 : 0)
                    }
                    .frame(width: 130, height: 130)
            } else {
            }
            
        }
        .position(x: UIScreen.main.bounds.width / 2, y: 100)
    }
    
    var climateButton: some View {
        
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(spacing: 20) {
                acSliderView
                fanSliderView
                heatSliderView
                autoSliderView
            }
            
        } label: {
        }
        .padding(.horizontal)
        
    }
    private var acSliderView: some View {
        HStack {
            Text("Ac")
                .frame(width: 50)
            Spacer()
                .frame(width: 20)
            Button {
                
            } label: {
                Image("acImage")
                    .renderingMode(.template)
                    .foregroundColor(isConditionerOn ? .topDradient : .textGray)
            }
            .neumorphismUNSelectedCircle()
            .neumorphismUnSelectedStyle()
            
            Spacer()
            CustomSliderView(value: $conditionerValue, minValue: 15, maxValue: 30, offset: $acOffset, colorOne: $selectedColor)
                .frame(width: 190)
            
            Spacer()
                .frame(width: 20)
            
        }
        .disabled(!isConditionerOn)
        .padding(.top, 10)
        .foregroundColor(.textGray)
        
    }
    
    private var fanSliderView: some View {
        HStack {
            Text("Fan")
                .frame(width: 50)
            Spacer()
                .frame(width: 20)
            Button {
                
            } label: {
                Image("fanImage")
            }
            .neumorphismUNSelectedCircle()
            .neumorphismUnSelectedStyle()
            
            Spacer()
            CustomSliderView(value: $fanValue, minValue: 15, maxValue: 30, offset: $fanOffset, colorOne: $selectedColor)
                .frame(width: 190)
            Spacer()
                .frame(width: 20)
            
        }
        .foregroundColor(.textGray)
        .padding(.top, 10)
        .disabled(!isConditionerOn)
        
    }
    
    private var heatSliderView: some View {
        HStack {
            Text("Heat")
                .frame(width: 50)
            Spacer()
                .frame(width: 20)
            Button {
                
            } label: {
                Image("heatImage")
            }
            .neumorphismUNSelectedCircle()
            .neumorphismUnSelectedStyle()
            
            Spacer()
            CustomSliderView(value: $heatValue, minValue: 15, maxValue: 30, offset: $heatOffset, colorOne: $selectedColor)
                .frame(width: 190)
            Spacer()
                .frame(width: 20)
            
        }
        .foregroundColor(.textGray)
        .padding(.top, 10)
        .disabled(!isConditionerOn)
        
    }
    private var autoSliderView: some View {
        HStack {
            Text("Auto")
                .frame(width: 50)
            Spacer()
                .frame(width: 20)
            Button {
            } label: {
                Image("autoImage")
            }
            .neumorphismUNSelectedCircle()
            .neumorphismUnSelectedStyle()
            
            Spacer()
            CustomSliderView(value: $autoValue, minValue: 15, maxValue: 30, offset: $autoOffset, colorOne: $selectedColor)
                .frame(width: 190)
            Spacer()
                .frame(width: 20)
            
        }
        .foregroundColor(.textGray)
        .padding(.vertical, 10)
        .disabled(!isConditionerOn)
        
    }
    private var bottomSheetHeaderView: some View {
        VStack {
            Capsule()
                .fill(.black)
                .frame(width: 80, height: 4)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("A/C is \(isConditionerOn ? "ON" : "OFF")")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text("Tap to turn off or swipe up \nfor a fast setup")
                        .foregroundColor(.gray)
                }
                Spacer()
                Button {
                    withAnimation {
                        isConditionerOn.toggle()
                    }
                } label: {
                    if #available(iOS 16.0, *) {
                        Image(systemName: "power")
                            .frame(width: 60, height: 60)
                            .tint(.white)
                            .overlay {
                                Circle()
                                    .stroke(selectedColor.opacity(0.6), lineWidth: 2)
                            }
                            .background(
                                Circle()
                                    .fill(
                                        .topDradient
                                            .shadow(.inner(color: .blue, radius: 12, x: 15, y: 10))
                                            .shadow(.inner(color: .blue, radius: 10, x: -1, y: -5))
                                    )
                                
                            )
                    } else {
                    }
                }
                .shadow(color: .darkShadow, radius: 6, x: 0, y: 0)
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    private var controlButtonsView: some View {
        HStack(alignment: .top,spacing: 50) {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 15)
                ColorPicker("", selection: $selectedColor)
                    .frame(width: 20)
                Spacer()
                    .frame(height: 40)
                Text("On")
                    .font(.system(size: 20))
            }
            .frame(height: 90)
            HStack() {
                Button {
                    guard conditionerValue > 15 else { return }
                    conditionerValue -= 1
                    acOffset -= 11
                } label: {
                    Image(.left)
                }
                .disabled(!isConditionerOn)
                
                Text("\(Int(conditionerValue))°")
                    .font(.system(size: 34))
                    .foregroundColor(.white)
                    .frame(width: 60)
                Button {
                    guard conditionerValue < 30 else { return }
                    conditionerValue += 1
                    acOffset += 11
                } label: {
                    Image(.right)
                }
                .disabled(!isConditionerOn)
                
            }
            VStack() {
                Spacer()
                    .frame(height: 15)
                Button {
                } label: {
                    Image(.vent)
                }
                Spacer()
                    .frame(height: 40)
                Text("Vent")
            }
            .frame(height: 80)
        }
        .frame(height: 100)
        .padding()
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, transaction in
                state = value.translation
                onChangeSettingsOffset()
            }
            .onEnded { value in
                let maxHeight = UIScreen.main.bounds.height / 5
                
                withAnimation {
                    if -currentSettingsOffsetY > maxHeight / 2 {
                        currentSettingsOffsetY = -maxHeight
                    } else {
                        currentSettingsOffsetY = 0
                    }
                    lastSettingsOffsetY = currentSettingsOffsetY
                }
            }
    }
    
    private func onChangeSettingsOffset() {
        DispatchQueue.main.async {
            self.currentSettingsOffsetY = gestureOffset.height + lastSettingsOffsetY
        }
    }
    
    
}

#Preview {
    ClimateView()
        .environment(\.colorScheme, .dark)
}
