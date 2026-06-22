"""
Voice assistant that listens to Russian speech, sends the text to a local LLM
(Ollama running Mistral), and speaks the response back.

Usage:
    python assistant.py

Say one of the exit keywords to stop:
    "выход", "остановить", "останови", "стоп",
    "заверши работу", "ассистент завершил работу", "до встречи"
"""

import re
import subprocess

import pyttsx3
import speech_recognition as sr

# Speech engine setup
engine = pyttsx3.init()
recognizer = sr.Recognizer()


def speak(text: str) -> None:
    """Speak the given text aloud."""
    engine.say(text)
    engine.runAndWait()


def listen() -> str | None:
    """Record from the microphone and convert speech to text (Russian)."""
    with sr.Microphone() as source:
        recognizer.adjust_for_ambient_noise(source, duration=1)
        print("Слушаю...")
        audio = recognizer.listen(source)

    try:
        text = recognizer.recognize_google(audio, language="ru-RU")
        print("Вы сказали:", text)
        speak(text)
        return text
    except sr.UnknownValueError:
        print("Речь не распознана")
        speak("Я не поняла")
        return None
    except sr.RequestError as e:
        print(f"Ошибка сервиса распознавания речи: {e}")
        speak("Ошибка подключения к сервису")
        return None


def chat_with_local_ai(prompt: str) -> str:
    """Send a prompt to the local Ollama LLM (Mistral) and return the reply."""
    try:
        result = subprocess.run(
            ["ollama", "run", "mistral", prompt],
            capture_output=True,
            text=True,
            timeout=60,
        )
        return result.stdout.strip()
    except Exception as e:
        print(f"Ошибка при обращении к Ollama: {e}")
        speak("Произошла ошибка при обращении к локальному ИИ")
        return "Ошибка общения с ИИ"


def main() -> None:
    exit_keywords = [
        "выход", "остановить", "останови", "стоп",
        "заверши работу", "ассистент завершил работу", "до встречи",
    ]

    while True:
        command = listen()
        if not command:
            continue

        # Normalise: drop punctuation, lowercase
        normalized = re.sub(r"[^\w\s]", "", command.lower()).strip()
        print(f"[DEBUG] Normalized command: '{normalized}'")

        if any(kw in normalized for kw in exit_keywords):
            speak("До встречи!")
            print("Assistant stopped.")
            break

        response = chat_with_local_ai(command)
        print(f"AI: {response}")
        speak(response)


if __name__ == "__main__":
    main()
