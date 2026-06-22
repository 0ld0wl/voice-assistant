# Voice Assistant

A small Python voice assistant that listens to Russian speech, sends the recognised text to a local LLM, and speaks the response back. Built as a personal side project to explore local LLM integration with audio I/O.

## How it works

1. Records audio from the microphone with `speech_recognition`
2. Converts speech to text via the Google Speech API (Russian language)
3. Sends the prompt to a local Ollama instance running the Mistral model
4. Speaks the response aloud with `pyttsx3`
5. Listens again, until an exit keyword is spoken

Everything except speech-to-text runs locally. No data is sent to OpenAI or any other commercial LLM provider.

## Requirements

- Python 3.10+
- [Ollama](https://ollama.com) installed and running locally
- Mistral model pulled: `ollama pull mistral`
- Microphone

## Installation

```bash
git clone https://github.com/0ld0wl/voice-assistant.git
cd voice-assistant

python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt
```

On macOS you may also need to install `portaudio` for the microphone backend:

```bash
brew install portaudio
```

## Usage

Make sure Ollama is running, then:

```bash
python assistant.py
```

The assistant will start listening. Speak to it in Russian. Say one of the exit keywords to stop:

`выход`, `остановить`, `останови`, `стоп`, `заверши работу`, `ассистент завершил работу`, `до встречи`

## Notes and limitations

- Speech-to-text uses Google's free API, which requires an internet connection
- Response latency depends on the local Mistral model and CPU
- The text-to-speech voice is whatever the system default is. On macOS that means a built-in voice; quality varies by language

## License

MIT
