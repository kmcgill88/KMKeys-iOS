// https://github.com/Quick/Quick

import Quick
import Nimble

import KMKeys

class KMKeysTest: QuickSpec {
    override func spec() {
        describe("init KMKeys: default") {
            
            
            let keys = KMKeys()
            
            
            it("has a toolbar and text field") {
                //expect() == 2
            }
            

//            it("can do maths") {
//                expect(1) == 2
//            }
//
//            it("can read") {
//                expect("number") == "string"
//            }
//
//            it("will eventually fail") {
//                expect("time").toEventually( equal("done") )
//            }
            
//            context("these will pass") {
//
//                it("can do maths") {
//                    expect(23) == 23
//                }
//
//                it("can read") {
//                    expect("🐮") == "🐮"
//                }
//
//                it("will eventually pass") {
//                    var time = "passing"
//
//                    DispatchQueue.main.async {
//                        time = "done"
//                    }
//
//                    waitUntil { done in
//                        Thread.sleep(forTimeInterval: 0.5)
//                        expect(time) == "done"
//
//                        done()
//                    }
//                }
//            }
        }
    }
}
