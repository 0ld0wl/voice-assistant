const phrases = [
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
];

const ball = document.getElementById('ball');
const message = document.getElementById('message');

let isShaking = false;
let lastPhrase = "";

ball.addEventListener('click', () => {
    console.log("Ball clicked");
    if (isShaking) {
        console.log("Already shaking, ignoring click");
        return;
    }

    isShaking = true;
    message.style.opacity = '0';
    ball.classList.add('shake');

    setTimeout(() => {
        let newPhrase;
        do {
            newPhrase = phrases[Math.floor(Math.random() * phrases.length)];
        } while (newPhrase === lastPhrase);

        lastPhrase = newPhrase;
        message.innerText = newPhrase;
        console.log("New phrase:", newPhrase);

        ball.classList.remove('shake');
        message.style.opacity = '1';

        setTimeout(() => {
            isShaking = false;
            console.log("Ready for next click");
        }, 500);
    }, 1000);
});
