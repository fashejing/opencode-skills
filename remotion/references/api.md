# Remotion API Reference

## Hooks

### useCurrentFrame()
Returns the current frame number (0-indexed).
```tsx
const frame = useCurrentFrame();
```

### useVideoConfig()
Returns video configuration object.
```tsx
const {width, height, fps, durationInFrames} = useVideoConfig();
```

## Animation Utilities

### interpolate()
Map a value from one range to another.
```tsx
const opacity = interpolate(frame, [0, 30], [0, 1]);
const x = interpolate(frame, [0, 100], [0, 500], {
  extrapolateLeft: 'clamp',
  extrapolateRight: 'clamp',
});
```

### spring()
Physics-based spring animation.
```tsx
const scale = spring({
  fps,
  frame,
  config: {damping: 10, mass: 0.5, stiffness: 100}
});
```

### Easing
```tsx
import {Easing, interpolate} from 'remotion';

const value = interpolate(frame, [0, 30], [0, 1], {
  easing: Easing.bezier(0.4, 0, 0.2, 1),
});
```

## Components

### `<AbsoluteFill />`
Full-screen container.
```tsx
<AbsoluteFill style={{backgroundColor: 'black'}}>
  <h1>Content</h1>
</AbsoluteFill>
```

### `<Sequence />`
Time-based sub-composition.
```tsx
<Sequence from={30} durationInFrames={60}>
  <MyComponent />
</Sequence>
```

### `<Audio />`
Add audio to composition.
```tsx
<Audio src="https://example.com/audio.mp3" />
<Audio src={staticFile('local-audio.mp3')} />
```

### `<Video />`
Embed video in composition.
```tsx
<Video src={staticFile('video.mp4')} />
```

### `<Img />`
Optimized image component.
```tsx
<Img src={staticFile('image.png')} />
```

### `<OffthreadVideo />`
Video rendered off-thread (better performance).
```tsx
<OffthreadVideo src={staticFile('bg.mp4')} />
```

## Helpers

### staticFile()
Reference files in public/ folder.
```tsx
import {staticFile} from 'remotion';

<Audio src={staticFile('music.mp3')} />
```

### getInputProps()
Access CLI input props.
```bash
npx remotion render comp out.mp4 --props='{"text":"Hello"}'
```
```tsx
const {text} = getInputProps();
```

## @remotion Packages

- `@remotion/player`: React player component
- `@remotion/gif`: GIF support
- `@remotion/lottie`: Lottie animations
- `@remotion/motion-graphics`: Motion graphics helpers
- `@remotion/three`: Three.js integration
- `@remotion/google-fonts`: Google Fonts loader
- `@remotion/tailwind`: Tailwind CSS support
