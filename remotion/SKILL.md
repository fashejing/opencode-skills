---
name: remotion
description: >
  Create and edit programmatic videos using Remotion (React-based video creation).
  Use when user wants to create videos from code, work with .tsx composition files,
  render videos from React components, use Remotion CLI commands, or build animations.
  Triggers on: remotion, video composition, react video, animation, .tsx video,
  npx remotion, create-video, sprite sheet animation, programmatic video.
---

# Remotion - Programmatic Video Creation

Remotion lets you create videos using React components. Write videos as code, render as MP4/GIF/WebM.

## When to Use

Use this skill when working with:
- Remotion/React video projects
- `.tsx` composition files
- Animation sequences and sprite sheets
- Video rendering via CLI
- Any programmatic video creation

---

## Quick Start

### Create New Project

```bash
# Interactive setup
npx create-video@latest

# Or use the init script
bash ~/.agents/skills/remotion/scripts/init-project.sh <project-name>
```

### Preview

```bash
npx remotion preview
```

### Render Video

```bash
# MP4 (default)
npx remotion render <composition-id> out/video.mp4

# GIF
npx remotion render <composition-id> out/anim.gif --codec=gif

# Specific frame range
npx remotion render <composition-id> out/video.mp4 --frames=0-299

# Scale for faster preview
npx remotion render <composition-id> out/video.mp4 --scale=0.5
```

### Still Image

```bash
npx remotion still <composition-id> out/frame.png --frame=30
```

---

## Core Concepts

| Concept | Description | Example |
|:---|:---|:---|
| **Composition** | A React component defining a video scene | `<Composition id="MyVideo" component={MyVideo} ... />` |
| **Duration** | Length in frames (30fps default) | 900 frames = 30s at 30fps |
| **FPS** | Frames per second (default 30) | `--fps=30` |
| **Dimensions** | Video resolution | 1920x1080 |

---

## Essential APIs

### useCurrentFrame()
Get current frame number (0-indexed):
```tsx
const frame = useCurrentFrame();
```

### useVideoConfig()
Get composition configuration:
```tsx
const {width, height, fps, durationInFrames, id} = useVideoConfig();
```

### interpolate()
Map values between ranges with easing:
```tsx
const opacity = interpolate(frame, [0, 30], [0, 1]);
const x = interpolate(frame, [0, 100], [0, 500], {
  extrapolateLeft: 'clamp',
  extrapolateRight: 'clamp',
  easing: Easing.bezier(0.4, 0, 0.2, 1),
});
```

### spring()
Physics-based animation:
```tsx
const scale = spring({
  fps,
  frame,
  config: {
    damping: 10,    // Deceleration
    mass: 1,        // Weight
    stiffness: 100, // Bounciness
  },
  durationInFrames: 40,
  delay: 10,
});
```

### Easing Functions
```tsx
import {Easing} from 'remotion';

// Bezier curve
Easing.bezier(0.4, 0, 0.2, 1)

// Common presets
Easing.linear
Easing.ease
Easing.in(Easing.ease)
Easing.out(Easing.ease)
Easing.inOut(Easing.ease)

// Advanced
Easing.bounce
Easing.elastic(1)
Easing.back(0.5)
```

---

## Core Components

### AbsoluteFill
Full-screen container:
```tsx
<AbsoluteFill style={{backgroundColor: 'black'}}>
  <h1>Content</h1>
</AbsoluteFill>
```

### Sequence
Time-based sub-composition:
```tsx
<Sequence from={30} durationInFrames={60}>
  <MyComponent />
</Sequence>
```

### Audio / Video / Img
```tsx
<Audio src={staticFile('music.mp3')} />
<Video src={staticFile('video.mp4')} />
<Img src={staticFile('image.png')} />
```

---

## Create a New Composition

```tsx
import {Composition} from 'remotion';
import {MyVideo} from './MyVideo';

export const Root: React.FC = () => {
  return (
    <Composition
      id="MyVideo"
      component={MyVideo}
      durationInFrames={900}
      fps={30}
      width={1920}
      height={1080}
      defaultProps={{text: "Hello"}}
    />
  );
};
```

---

## Animation Patterns

### Delayed Animation
```tsx
const delayedFrame = Math.max(0, frame - 20);
const value = spring({fps, frame: delayedFrame});
```

### Loop Animation
```tsx
const loopFrame = frame % 60;
const value = spring({fps, frame: loopFrame});
```

### Reverse Animation
```tsx
const reverseFrame = durationInFrames - frame;
const value = spring({fps, frame: reverseFrame});
```

### Combined Animation
```tsx
export const AnimatedBox: React.FC = () => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  
  const scale = spring({
    fps, frame,
    config: {damping: 10, mass: 0.5, stiffness: 100}
  });
  
  const opacity = interpolate(frame, [0, 30, 60, 90], [0, 1, 1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  
  return (
    <div style={{transform: `scale(${scale})`, opacity}}>
      Animated content
    </div>
  );
};
```

---

## CLI Reference

| Command | Description |
|:---|:---|
| `remotion preview` | Start dev server |
| `remotion render <id> out.mp4` | Render MP4 |
| `remotion render <id> out.gif --codec=gif` | Render GIF |
| `remotion still <id> out.png --frame=30` | Single frame |
| `remotion compositions` | List compositions |

### Codecs

| Codec | Extension | Use Case |
|:---|:---|:---|
| h264 | .mp4 | Default, best compatibility |
| h265 | .mp4 | Smaller files |
| vp8/vp9 | .webm | Web playback |
| prores | .mov | Professional editing |
| gif | .gif | Animated GIF |

---

## Sprite Sheet Animation

For sprite sheet animations (like HappyFrame output):

```tsx
import {useCurrentFrame, interpolate} from 'remotion';

const SpriteSheet: React.FC<{src: string; cols: number; rows: number}> = ({src, cols, rows}) => {
  const frame = useCurrentFrame();
  const currentFrame = frame % (cols * rows);
  const col = currentFrame % cols;
  const row = Math.floor(currentFrame / cols);
  
  return (
    <div
      style={{
        width: '100%',
        height: '100%',
        backgroundImage: `url(${src})`,
        backgroundSize: `${cols * 100}% ${rows * 100}%`,
        backgroundPosition: `${-col * 100}% ${-row * 100}%`,
      }}
    />
  );
};
```

---

## Advanced Topics

See the rules directory for detailed guides:

| Topic | When Needed |
|:---|:---|
| **3d.md** | Three.js and React Three Fiber |
| **animations.md** | Fundamental animation skills |
| **audio.md** | Audio import, trimming, volume |
| **charts.md** | Data visualization |
| **compositions.md** | Defining compositions |
| **fonts.md** | Google Fonts and local fonts |
| **gifs.md** | GIF synchronization |
| **images.md** | Image embedding |
| **lottie.md** | Lottie animations |
| **maps.md** | Mapbox integration |
| **parameters.md** | Zod schema for props |
| **sequencing.md** | Delay, trim, duration |
| **text-animations.md** | Typography patterns |
| **timing.md** | Interpolation curves |
| **transitions.md** | Scene transitions |
| **transparent-videos.md** | Alpha channel output |
| **trimming.md** | Cut beginning/end |
| **videos.md** | Video embedding |
| **display-captions.md** | Subtitles/captions |

---

## Tips

- Test in preview mode before rendering (`npx remotion preview`)
- Use `extrapolate: 'clamp'` to prevent values going outside range
- Combine `spring()` with `interpolate()` for complex animations
- Render in CI/CD: `npx remotion render` works headless
- Audio: Use `<Audio>` component with local or remote sources
- Fonts: Load web fonts in `public/` or use `@remotion/google-fonts`

---

## Resources

- [Remotion Docs](https://www.remotion.dev/docs)
- [Spring Animation Editor](https://www.remotion.dev/timing-editor)
- [Easing Functions](https://easings.net/)
- [Cubic Bezier Tool](https://cubic-bezier.com/)