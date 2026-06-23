# Terminal Voice Companion

A voice conversation layer for [Claude Code](https://github.com/anthropics/claude-code). Hold a key to talk, hear short spoken replies, and cut it off mid-sentence when you want to change direction. Runs on your Claude subscription, with speech recognition and speech synthesis running locally on your machine.

**Status:** early work in progress. Not usable yet. Built in the open.

## What this is

A lightweight companion around Claude Code that gives you a real back-and-forth voice conversation: push-to-talk to speak, short spoken summaries back, and the ability to interrupt it by talking (barge-in). The code stays on your screen the whole time. Voice is for talking through problems, giving instructions, and hearing short summaries, never for reading code out loud.

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
- **Interaction:** push-to-talk. Hold a key to speak, release to send. Holding the key while it is talking interrupts it. Push-to-talk also sidesteps echo cancellation, since the mic stays closed unless you are holding the key.
- **Cost:** roughly zero marginal cost. The subscription is already paid, and the speech models run locally.

## Roadmap

Phase 1, the part that makes voice actually feel fluid:

- [ ] Baseline: VoiceMode running against Claude Code on the subscription
- [ ] Warm the speech models at startup so the first reply is not a multi-second freeze
- [ ] Push-to-talk with real barge-in (key down while it speaks aborts playback)
- [ ] Stop it speaking code and file paths out loud (filter the spoken stream, ask for short spoken summaries)

Later, only if Phase 1 feels good: a command panel for firing preset commands, and custom voice commands.

## Built on

- [VoiceMode](https://github.com/mbailey/voicemode) (MIT) for the local voice stack
- [whisper.cpp](https://github.com/ggerganov/whisper.cpp) for speech to text
- [Kokoro](https://github.com/hexgrad/kokoro) for text to speech

## License

[MIT](LICENSE). Open source, use it however you want.
