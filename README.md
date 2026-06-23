# Terminal Voice Companion

A voice conversation layer for [Claude Code](https://github.com/anthropics/claude-code). Hold a key to talk, hear short spoken replies, and cut it off mid-sentence when you want to change direction. Runs on your Claude subscription, with speech recognition and speech synthesis running locally on your machine.

**Status:** early work in progress. Not usable yet. Built in the open.

## What this is

A lightweight companion around Claude Code that gives you a real back-and-forth voice conversation: it listens while you talk, gives short spoken summaries back, and lets you interrupt it by talking (barge-in). The code stays on your screen the whole time. Voice is for talking through problems, giving instructions, and hearing short summaries, never for reading code out loud.

It is not hands-free, eyes-off coding. When Claude is actually editing files you will sit in silence, because the voice layer cannot speed that part up. Think of it as a talk-and-glance layer over Claude Code, not a replacement for looking at the screen.

## Why

There are plenty of voice dictation tools (speech into a prompt) and plenty of cloud voice agents (that own and meter their own model call). Nothing does all three of these at once:

- Real barge-in: interrupt the assistant by talking over it
- Runs on a Claude Pro/Max subscription, not a metered API key
- Fully local speech, so no per-minute cloud transcription or synthesis cost

This is an attempt to fill that gap.

## How it works

- **Brain:** Claude Code, on your existing subscription. No per-token billing.
- **Voice:** built on [VoiceMode](https://github.com/mbailey/voicemode), an MCP server that runs local Whisper (speech to text) and Kokoro (text to speech). Because the voice runs as a tool inside a normal interactive Claude Code session, it stays on your subscription with no API metering.
- **Interaction:** two modes, switchable in settings. Default is open-mic: it listens continuously and uses voice detection to know when you have finished talking, like a normal voice call. Optional push-to-talk: hold a key to speak, release to send, for noisy rooms or when you are not on headphones. Either way, talking while it speaks interrupts it (barge-in). Open-mic needs headphones, otherwise the mic picks up the speech output and it interrupts itself.
- **Cost:** roughly zero marginal cost. The subscription is already paid, and the speech models run locally.

## Built on

- [VoiceMode](https://github.com/mbailey/voicemode) (MIT) for the local voice stack
- [whisper.cpp](https://github.com/ggerganov/whisper.cpp) for speech to text
- [Kokoro](https://github.com/hexgrad/kokoro) for text to speech

## License

[MIT](LICENSE). Open source, use it however you want.
