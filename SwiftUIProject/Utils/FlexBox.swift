import SwiftUI

struct FlexBox<Item:Hashable, Content:View>:View{
    
    @Binding var array:[Item]
    @ViewBuilder var content: (Item)->Content
    
    var body: some View{
        GeometryReader{ geo in
            generateContent(in: geo)
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(array, id: \.self) { item in
                content(item)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == self.array.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if item == self.array.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
    
}
