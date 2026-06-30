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

ball.addEventListener('click', () => {
    if (isShaking) return;

    isShaking = true;
    message.classList.add('fade-out');
    ball.classList.add('shake');

    setTimeout(() => {
        const randomIndex = Math.floor(Math.random() * phrases.length);
        message.innerText = phrases[randomIndex];

        ball.classList.remove('shake');
        message.classList.remove('fade-out');
        message.classList.add('fade-in');

        setTimeout(() => {
            message.classList.remove('fade-in');
            isShaking = false;
        }, 500);
    }, 1000);
});
