//
//  GridButtons.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 10/03/24.
//



import SwiftUI

struct GridButtons: View {
    let tags: [String]
    @State private var selectedIndices: Set<Int> = []

    @State private var totalHeight = CGFloat.zero

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags.indices, id: \.self) { index in
                let tag = self.tags[index]
                self.item(for: tag, isSelected: self.selectedIndices.contains(index))
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if index == self.tags.indices.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if index == self.tags.indices.last! {
                            height = 0 // last item
                        }
                        return result
                    })
                    .onTapGesture {
                        toggleSelection(index)
                    }
                
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String, isSelected: Bool) -> some View {
        Text(text)
            .frame(width: .infinity, height: 12)
            .font(.system(size: 11.5))
            .foregroundColor(isSelected ? .white : .black)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(isSelected ? Color(UIColor(hex: "#7F32CD")) : Color.white)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
            .padding(.trailing, 7)
            .padding(.bottom, 5)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }

    private func toggleSelection(_ index: Int) {
        if selectedIndices.contains(index) {
            selectedIndices.remove(index)
        } else {
            selectedIndices.insert(index)
        }
    }
}

struct HashTagView_Previews: PreviewProvider {
    static var previews: some View {
        GridButtons(tags: ["WiFi", "TV", "Parking", "Washing Machine", "Lift", "Hot Water", "Lounge", "Gym"])
            
    }
}
