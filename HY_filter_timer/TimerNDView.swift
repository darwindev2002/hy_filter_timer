//
//  TimerNDView.swift
//  HY_filter_timer
//
//  Created by Darwin Chan on 10/6/2021.
//

import SwiftUI

struct TimerNDView: View {
    let cardWidth: Int
    @Binding var offset: CGFloat
    let height: Int
    let backgroundColor: Color
    let textColor: Color
    
    var NDs: [Double:Int] = [1.5: 3,
                               2: 4,
                               3: 8,
                               4: 16,
                               5: 32,
                               6: 64,
                               7: 128,
                               8: 256,
                             8.5: 400,
                               9: 500,
                               10: 1000,
                               11: 2000,
                               12: 4000,
                               13: 8000,
                               14: 16000,
                               15: 32000,
                               16: 64000,
                               17: 128000,
                               18: 256000,
                               19: 500000,
                               20: 1000000]
    var body: some View {
        GeometryReader{ gp in
//            Text("\(getStops())")
            ZStack {
                CustomSlider(cardWidth: cardWidth, pickerCount: NDs.count, offset: $offset, backgroundColor: backgroundColor, content: {
                    HStack(spacing: 0) {
                        ForEach(NDs.sorted(by: <), id: \.key) { key, value in
                            VStack {
                                Text("ND\(value)")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                Text("\(stopsRound(stops: key))")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                            }
                            .frame(width: CGFloat(cardWidth))
                        }
                    }
                })
                .foregroundColor(textColor)
                .background(backgroundColor)
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: backgroundColor.opacity(0.01), location: 0),
                            .init(color: backgroundColor, location: 1)
                        ]), startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: 0.3 * gp.size.width)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: backgroundColor.opacity(0.01), location: 0),
                            .init(color: backgroundColor, location: 1)
                        ]), startPoint: .trailing, endPoint: .leading)
                    )
                    .frame(width: 0.3 * gp.size.width)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(height: 50)
    }
    
    func getStops()->String {
        return "\(NDs.sorted(by: <)[Int(round(Double(offset) / 106))].key) stops"
    }
    
    func stopsRound(stops: Double) -> String {
        if floor(stops)==stops { return "\(Int(stops)) STOPS" }
        else { return "\(stops*10/10) STOPS" }
    }
}

struct TimerNDView_Previews: PreviewProvider {
    static var previews: some View {
        TimerNDView(cardWidth: 106, offset: .constant(0), height: 50, backgroundColor: Color("BackgroundColor"), textColor: Color("TextColor"))
    }
}
