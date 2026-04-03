# Remotion CLI Reference

## Commands

### `remotion preview`
Start development server for live preview.
```bash
npx remotion preview
# Custom port
npx remotion preview --port=3001
```

### `remotion render`
Render video from composition.
```bash
# Basic
npx remotion render <composition-id> out.mp4

# With options
npx remotion render <id> out.mp4 --codec=h264 --quality=100
npx remotion render <id> out.gif --codec=gif --every-nth-frame=2
npx remotion render <id> out.webm --codec=vp8

# Frame range
npx remotion render <id> out.mp4 --frames=0-299

# Scale for faster renders
npx remotion render <id> out.mp4 --scale=0.5
```

### `remotion still`
Render single frame as image.
```bash
npx remotion still <composition-id> out.png --frame=150
```

### `remotion compositions`
List all available compositions.
```bash
npx remotion compositions
```

### `remotion lambda`
Render on AWS Lambda (serverless).
```bash
# Setup
npx remotion lambda policies validate
npx remotion lambda sites create

# Render
npx remotion lambda render <site-url> <composition-id>
```

## Codecs

| Codec | Extension | Use Case |
|-------|-----------|----------|
| h264 | .mp4 | Default, best compatibility |
| h265 | .mp4 | Smaller files, slower encode |
| vp8 | .webm | Web playback |
| vp9 | .webm | Web, better quality than vp8 |
| prores | .mov | Professional editing |
| gif | .gif | Animated GIF |

## Common Options

- `--codec`: Output format (h264, h265, vp8, vp9, prores, gif)
- `--quality`: 1-100 for h264/h265
- `--frames`: Render specific frame range (e.g., 0-299)
- `--scale`: Downscale for faster preview (0.5 = half resolution)
- `--concurrency`: Number of parallel renders
- `--overwrite`: Overwrite existing output file
- `--log`: Verbose logging (verbose, info, warn, error)

## Environment Variables

```bash
REMOTION_AWS_ACCESS_KEY_ID=
REMOTION_AWS_SECRET_ACCESS_KEY=
REMOTION_CLOUDFRONT_DOMAIN=
```
