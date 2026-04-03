---
name: remotionmax-win
description: >
  Create Remotion animations, open in editor, and start preview in one command (Windows).
  Use when user wants to create animated videos with Remotion on Windows, open the project in VS Code or Cursor,
  and start the live preview server.
  Triggers on: create animation, remotion preview, open video editor, start remotion, animation studio, remotionmax.
---

# RemotionMAX-WIN - Animation Studio in One Click (Windows)

Create stunning Remotion animations, open in your favorite editor, and preview in real-time.

## What is RemotionMAX-WIN?

RemotionMAX-WIN combines three steps into one:
1. **Create** - Generate animation code based on your theme(s)
2. **Open** - Launch in VS Code (default) or Cursor
3. **Preview** - Start live preview server

## Usage

### Interactive Mode (Recommended)

Simply trigger the skill:
```bash
remotionmax-win
```

### Command Line Mode

```powershell
# Single animation
.\launch.ps1 -Name "my-animation" -Theme "neon glow logo"

# Multiple animations in one project
.\launch.ps1 -Name "my-animations" -Animations @("neon glow logo", "pixel art", "retro gaming")

# With VS Code (default)
.\launch.ps1 -Name "my-project" -Animations @("cyberpunk glitch", "particle explosion")

# With Cursor
.\launch.ps1 -Name "my-project" -Animations @("rainbow wave") -Editor "cursor"
```

## Key Features

- **Multiple animations per project**: Create several animations and they will all be in the same project
- **VS Code as default editor**: Opens in VS Code by default (change with `-Editor cursor`)
- **Auto-detect animation style**: Based on theme keywords (pixel, retro, glitch, particle, wave, neon)
- **Smart naming**: Converts themes to PascalCase component names

## Animation Themes

When you describe your animation theme, RemotionMAX-WIN can create:

| Theme Type | Keywords | Examples |
|:---|:---|:---|
| **Neon** | (default) | neon glow, holographic, glow logo |
| **Pixel** | pixel, retro, 8-bit | pixel art, retro gaming, 8-bit |
| **Glitch** | glitch, corrupt | glitch effect, corrupt text |
| **Particle** | particle, firework | particle explosion, firework |
| **Wave** | wave, text | text wave, rainbow wave |
| **Geometric** | geometric, shape | geometric shapes, rotating forms |

## Animation Code Examples

### Neon Glow (default)
```tsx
const scale = spring({ fps, frame, config: { damping: 12, stiffness: 100 } });
const opacity = interpolate(frame, [0, 30, 120, 150], [0, 1, 1, 0]);

// Glowing text with particle background
<div style={{
  fontSize: 120,
  color: '#fff',
  textShadow: '0 0 30px rgba(255, 0, 255, 0.8), 0 0 60px rgba(0, 255, 255, 0.6)',
  transform: `scale(${scale})`,
  opacity,
}}>
  EMOWOWO
</div>
```

### Pixel Art Style
```tsx
// Grid background with pixel blocks
// Monospace font with text-shadow glow
// Floating colored square particles
```

### Glitch Effect
```tsx
// RGB split effect
// Random glitch blocks
// Scanline overlay
```

## Workflow

```
1. You describe your animation theme(s)
       ↓
2. RemotionMAX-WIN generates animation code
       ↓
3. All animations added to same project
       ↓
4. Project opens in VS Code
       ↓
5. Preview server starts automatically
       ↓
6. Open http://localhost:3456 to preview!
```

## After Launch

### Preview
- Open http://localhost:3456 (or the port shown)
- Select different compositions to preview each animation
- Edit code and watch changes instantly

### Render
```powershell
# List all compositions
npx remotion compositions

# Render single animation
npx remotion render NeonGlowLogo out.mp4

# Render all as separate files
npx remotion render

# Render as GIF
npx remotion render <CompositionId> out.gif --codec=gif

# Render single frame
npx remotion still <CompositionId> out.png --frame=30
```

## Project Structure

```
{project-name}/
├── src/
│   ├── index.tsx              # Root with all Compositions
│   ├── Root.tsx               # Same as index.tsx
│   └── animations/
│       ├── NeonGlowLogo.tsx   # Animation component
│       ├── PixelArtRetro.tsx  # Another animation
│       └── index.ts           # Exports all animations
├── public/
├── package.json
├── tsconfig.json
└── node_modules/
```

## Tips

- **Multiple animations**: Use `-Animations @("theme1", "theme2", "theme3")` to create several at once
- **Composition selector**: Click the Remotion Studio logo to switch between animations
- **Frame-by-frame**: Use the timeline to scrub through frames
- **Export**: When happy, render to MP4 or GIF

## Resources

- [Remotion Docs](https://www.remotion.dev/docs)
- [Timing Functions](https://www.remotion.dev/docs/interpolate)
- [Spring Animation](https://www.remotion.dev/docs/spring)
- [Easing Functions](https://easings.net/)