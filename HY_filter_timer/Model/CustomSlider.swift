//
//  CustomSlider.swift
//  HY_filter_timer
//
//  Created by Darwin Chan on 10/6/2021.
//

import Foundation
import SwiftUI

struct CustomSlider<Content: View>: UIViewRepresentable {
    var content: Content
    @Binding var offset: CGFloat
    var pickerCount: Int
    var cardWidth: Int
    var backgroundColor: Color
    init(cardWidth: Int, pickerCount: Int, offset: Binding<CGFloat>, backgroundColor: Color, @ViewBuilder content: @escaping ()->Content) {
        self.content = content()
        self._offset = offset
        self.pickerCount = pickerCount
        self.cardWidth = cardWidth
        self.backgroundColor = backgroundColor
    }
    func makeCoordinator() -> Coordinator {
        return CustomSlider.Coordinator(parent: self)
    }
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let swiftUIView = UIHostingController(rootView: content).view!
        let width = CGFloat(pickerCount * cardWidth) + (getRect().width - 110)
        swiftUIView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        swiftUIView.backgroundColor = UIColor(backgroundColor)
        scrollView.contentSize = swiftUIView.frame.size
        scrollView.addSubview(swiftUIView)
        scrollView.bounces = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        return scrollView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: CustomSlider
        var cardWidth: Int
        var lowerBound: CGFloat
        var upperBound: CGFloat
        init(parent: CustomSlider) {
            self.parent = parent
            self.cardWidth = parent.cardWidth
            self.lowerBound = -CGFloat(cardWidth/2)
            self.upperBound = CGFloat(self.cardWidth * self.parent.pickerCount) - -lowerBound
        }
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
            if parent.offset < lowerBound+1 {
                parent.offset = lowerBound+1
            }
            if parent.offset > upperBound-1 {
                parent.offset = upperBound-1
            }
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            let value = (offset / 106).rounded(.toNearestOrAwayFromZero)
            scrollView.setContentOffset(CGPoint(x: value * 106, y: 0), animated: true)
        }
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                let offset = scrollView.contentOffset.x
                let value = (offset / 106).rounded(.toNearestOrAwayFromZero)
                scrollView.setContentOffset(CGPoint(x: value * 106, y: 0), animated: true)
            }
        }
    }
}

func getRect() -> CGRect {
    return UIScreen.main.bounds
}
