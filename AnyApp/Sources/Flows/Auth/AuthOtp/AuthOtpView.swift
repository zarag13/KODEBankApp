import UI
import UIKit
import AppIndependent
import Combine

final class AuthOtpView: BackgroundPrimary {

    var onOtpFilled: VoidHandler?

    private let otp = OtpTextField()
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        otp.otpEvent = { [weak self] event in
            switch event {
            case .codeIsEntered:
                self?.onOtpFilled?()
            }
        }
    }

    private func body() -> UIView {
        VStack {
            MainNavigationBar()
            //navigationBar
            VStack {
                Label(text: "На ваш номер отправлено SMS с кодом подтверждения", foregroundStyle: .textPrimary, fontStyle: .button)
                    .linesCount(0)
                Spacer(.px24)
                otp
                    .height(48)
                Spacer(.px24)
                Label(text: "Повторить через 2:59", foregroundStyle: .textPrimary, fontStyle: .button)
            }
                .layoutMargins(.make(vInsets: 16))
            FlexibleSpacer()
            Spacer(.px32)
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
//    
//    private var navigationBar: NavigationBar {
//        NavigationBar { view in
//            body().embed(in: view)
//            func body() -> UIView {
//                HStack {
//                    ImageView(image: Asset.leftBackIcon.image)
//                        .height(24)
//                        .width(24)
//                        .huggingPriority(.defaultHigh, axis: .horizontal)
//                        .onTap {
//                            print("back")
//                        }
//                    FlexibleSpacer()
//                }.layoutMargins(.make(vInsets: 10))
//            }
//        }
//    }
}
