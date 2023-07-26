//
//  GraphView.swift
//  notbs
//
//  Created by Pranav Krishnan on 7/16/23.
//

import SwiftUI

struct GraphView: View {
    let color: Color

    var body: some View {
        ZStack {
            GraphBackground()
            ScatterPlot()
                .stroke(color, lineWidth: 2)
        }
        .frame(height: 200)
        .padding(.horizontal)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(color, lineWidth: 2)
        )
    }
}

struct GraphBackground: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                let xSpacing = width / 5
                let ySpacing = height / 5
                
                for index in 0..<6 {
                    path.move(to: CGPoint(x: CGFloat(index) * xSpacing, y: 0))
                    path.addLine(to: CGPoint(x: CGFloat(index) * xSpacing, y: height))
                }
                
                for index in 0..<6 {
                    path.move(to: CGPoint(x: 0, y: CGFloat(index) * ySpacing))
                    path.addLine(to: CGPoint(x: width, y: CGFloat(index) * ySpacing))
                }
            }
            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        }
    }
}

struct ScatterPlot: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let dataPoints = (1...20).map { _ in CGFloat.random(in: rect.minY...rect.maxY) }

        let xSpacing = rect.width / CGFloat(dataPoints.count - 1)

        for index in dataPoints.indices {
            let xPosition = CGFloat(index) * xSpacing
            let yPosition = dataPoints[index]

            if index == 0 {
                path.move(to: CGPoint(x: xPosition, y: yPosition))
            } else {
                path.addLine(to: CGPoint(x: xPosition, y: yPosition))
            }
            
            path.addArc(center: CGPoint(x: xPosition, y: yPosition), radius: 2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        }

        return path
    }
}

