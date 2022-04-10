import SwiftUI

struct CheckboxFieldView : View {
    
    @State var width:CGFloat = 20
    @State var height:CGFloat = 20
    @State var checkState:Bool = false

    var body: some View {

         Button(action:
            {
                //1. Save state
                self.checkState = !self.checkState
                print("State : \(self.checkState)")


        }) {
            HStack(alignment: .top) {
                   Image(self.checkState ? "ico-checkbox-active" : "ico-checkbox-inactive")
                    .frame(width:width, height:height, alignment: .center)
                    .cornerRadius(5)
            }
        }
        .foregroundColor(Color.white)

    }

}
