import SwiftUI

struct ContentView: View {
    let phrases = [
        "У тебя всё получится!",
        "Ты сильнее, чем думаешь",
        "Просто продолжай идти",
        "Верь в себя",
        "Это временные трудности",
        "Ты на верном пути",
        "Дыши глубже",
        "Всё будет хорошо",
        "Ты молодец!",
        "Не сдавайся",
        "Твои усилия окупятся",
        "Ты важен",
        "Завтра будет лучше",
        "Следуй за мечтой",
        "Ты уникален",
        "Всё к лучшему",
        "Действуй смело",
        "Мир на твоей стороне",
        "Фокусируйся на хорошем",
        "Ты справишься"
    ]

    @State private var message: String = "Нажми на меня"
    @State private var isShaking = false
    @State private var messageOpacity = 1.0
    @State private var lastPhrase = ""

    var body: some View {
        ZStack {
            Color(red: 44/255, green: 62/255, blue: 80/255)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Text("Шар Поддержки")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(.white)

                ZStack {
                    // Ball Shadow
                    Ellipse()
                        .fill(Color.black.opacity(0.3))
                        .frame(width: 200, height: 30)
                        .blur(radius: 10)
                        .offset(y: 160)

                    // The Ball
                    Circle()
                        .fill(
                            RadialGradient(gradient: Gradient(colors: [Color(white: 0.2), .black]), center: .topLeading, startRadius: 50, endRadius: 300)
                        )
                        .frame(width: 300, height: 300)
                        .shadow(color: .black.opacity(0.5), radius: 20, x: 10, y: 10)

                    // The Window
                    Circle()
                        .fill(Color(white: 0.1))
                        .frame(width: 160, height: 160)
                        .overlay(
                            Circle()
                                .stroke(Color(white: 0.15), lineWidth: 4)
                        )

                    // The Triangle and Message
                    Triangle()
                        .fill(Color.blue.opacity(0.8))
                        .frame(width: 140, height: 120)
                        .overlay(
                            Text(message)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: 100)
                                .padding(.top, 40)
                                .opacity(messageOpacity)
                        )
                }
                .offset(x: isShaking ? -10 : 0)
                .onTapGesture {
                    shakeBall()
                }

                Text("Нажми на шар, чтобы получить поддержку")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.top, 20)
            }
        }
    }

    func shakeBall() {
        guard !isShaking else { return }

        withAnimation(.easeInOut(duration: 0.1).repeatCount(10, autoreverses: true)) {
            isShaking = true
        }

        withAnimation(.easeInOut(duration: 0.5)) {
            messageOpacity = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isShaking = false

            var newPhrase: String
            repeat {
                newPhrase = phrases.randomElement() ?? "Всё будет хорошо"
            } while newPhrase == lastPhrase

            lastPhrase = newPhrase
            message = newPhrase

            withAnimation(.easeInOut(duration: 0.5)) {
                messageOpacity = 1.0
            }
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
