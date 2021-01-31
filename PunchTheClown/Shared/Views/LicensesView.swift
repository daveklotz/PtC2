//
//  LicensesView.swift
//  iOS
//
//  Created by David Klotz on 1/31/21.
//

import SwiftUI

struct LicensesView: View {
    var body: some View {
        ScrollView {
            GroupBox {
                
                Text("ML models used under MIT license from: https://github.com/novinfard/profiler-sentiment-analysis")
                Text("MIT License\n\nCopyright (c) 2018 Soheil Novinfard\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\n                THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.")
                
            } // end GroupBox
            GroupBox {
                Text("List of fortunes partially drawn from https://github.com/ruanyf/fortunes under the BSD license.")
                Text("BSD license found at: https://opensource.org/licenses/BSD-2-Clause")
            }
            GroupBox {
                Text("All other rights held solely by Me.")
            }
        } // End ScrollView
        
    }
}

struct LicensesView_Previews: PreviewProvider {
    static var previews: some View {
        LicensesView()
    }
}
