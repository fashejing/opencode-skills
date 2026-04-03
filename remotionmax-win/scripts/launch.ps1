# remotionmax-win - One-click animation studio (Windows PowerShell)
# Creates animation, opens editor, starts preview

param(
    [string]$Name = "",
    [string]$Theme = "",
    [string]$Editor = "",
    [string]$Template = "hello-world",
    [string]$ProjectPath = "$env:USERPROFILE\Documents\emowowo remotion",
    [int]$Port = 3456,
    [switch]$Auto,
    [string[]]$Animations = @()
)

# Colors
$RED = "`e[0;31m"
$GREEN = "`e[0;32m"
$YELLOW = "`e[1;33m"
$BLUE = "`e[0;34m"
$PURPLE = "`e[0;35m"
$CYAN = "`e[0;36m"
$NC = "`e[0m"

$MAX_RETRIES = 5

# Banner
Write-Host "$CYAN"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host "  ██████╗██████╗ ██╗   ██╗██████╗ ████████╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗"
Write-Host " ██╔════╝██╔══██╗╚██╗ ██╔╝██╔══██╗╚══██╔══╝██╔═══██╗██╔═══██╗██╔══██╗╚██╗ ██╔╝"
Write-Host " ██║     ██████╔╝ ╚████╔╝ ██████╔╝   ██║   ██║   ██║██║   ██║██████╔╝ ╚████╔╝ "
Write-Host " ██║     ██╔══██╗  ╚██╔╝  ██╔═══╝    ██║   ██║   ██║██║   ██║██╔══██╗  ╚██╔╝  "
Write-Host " ╚██████╗██║  ██║   ██║   ██║        ██║   ╚██████╔╝╚██████╔╝██║  ██║   ██║   "
Write-Host "  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝        ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝   ╚═╝   "
Write-Host "                                          MAX-WIN"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host "$NC"
Write-Host "$YELLOW""One-click Animation Studio (Windows PowerShell)$NC"
Write-Host ""

# Interactive mode
if (-not $Auto) {
    Write-Host "$BLUE""📝 Step 1: Project Details$NC"

    if ([string]::IsNullOrEmpty($Name)) {
        $Name = Read-Host "   Enter project name (default: my-animation)"
        if ([string]::IsNullOrEmpty($Name)) { $Name = "my-animation" }
    }

    if ([string]::IsNullOrEmpty($Editor)) {
        Write-Host ""
        Write-Host "$BLUE""💻 Step 2: Choose Editor$NC"
        Write-Host "   1) VS Code (default)"
        Write-Host "   2) Cursor"
        Write-Host ""
        $choice = Read-Host "   Select editor (1 or 2)"
        if ($choice -eq "2") { $Editor = "cursor" } else { $Editor = "vscode" }
    }

    if ($Animations.Count -eq 0) {
        Write-Host ""
        Write-Host "$BLUE""🎨 Step 3: Animation Theme(s)$NC"
        Write-Host "   Enter animation themes (comma separated for multiple):"
        Write-Host "   Examples:"
        Write-Host "   - 'neon glow logo'"
        Write-Host "   - 'particle explosion, rainbow wave, cyberpunk glitch'"
        Write-Host ""
        $themeInput = Read-Host "   Enter animation theme(s)"
        if (-not [string]::IsNullOrEmpty($themeInput)) {
            $Animations = $themeInput -split ',' | ForEach-Object { $_.Trim() }
        }
        if ($Animations.Count -eq 0 -or [string]::IsNullOrEmpty($Animations[0])) {
            $Animations = @("neon glow logo")
        }
    }
}

# Set defaults
if ([string]::IsNullOrEmpty($Name)) { $Name = "my-animation" }
if ([string]::IsNullOrEmpty($Editor)) { $Editor = "vscode" }
if ([string]::IsNullOrEmpty($ProjectPath)) { $ProjectPath = "$env:USERPROFILE\Documents\emowowo remotion" }
if ($Animations.Count -eq 0 -or [string]::IsNullOrEmpty($Animations[0])) { $Animations = @("neon glow logo") }

$FullPath = "$ProjectPath\$Name"

Write-Host ""
Write-Host "$CYAN""━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
Write-Host "$GREEN""📦 Creating animation project...$NC"
Write-Host "$CYAN""━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
Write-Host "   Project: $Name"
Write-Host "   Animations: $($Animations -join ', ')"
Write-Host "   Editor: $Editor"
Write-Host "   Path: $FullPath"
Write-Host ""

# Create project directory
$projectDir = $FullPath
$isNewProject = -not (Test-Path $projectDir)

if ($isNewProject) {
    Write-Host "$GREEN""📁 Creating new project structure...$NC"
    New-Item -Path "$projectDir\src\animations" -ItemType Directory -Force | Out-Null
    New-Item -Path "$projectDir\public" -ItemType Directory -Force | Out-Null

    # Create package.json
    $packageJson = @"
{
  "name": "$($Name -replace '\s+', '-')",
  "version": "1.0.0",
  "description": "Created with RemotionMAX-WIN",
  "scripts": {
    "start": "remotion preview",
    "build": "remotion render",
    "preview": "remotion preview"
  },
  "dependencies": {
    "@remotion/cli": "^4.0.0",
    "@remotion/bundler": "^4.0.0",
    "remotion": "^4.0.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  }
}
"@
    Set-Content -Path "$projectDir\package.json" -Value $packageJson -Encoding UTF8

    # Create tsconfig.json
    $tsconfig = @"
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "lib": ["ES2020", "DOM"],
    "jsx": "react-jsx",
    "strict": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "skipLibCheck": true
  },
  "include": ["src/**/*"]
}
"@
    Set-Content -Path "$projectDir\tsconfig.json" -Value $tsconfig -Encoding UTF8

    # Create public folder placeholder
    "" | Out-File -FilePath "$projectDir\public\.gitkeep" -Encoding utf8
} else {
    Write-Host "$YELLOW""📂 Adding animations to existing project...$NC"
    # Ensure animations directory exists
    if (-not (Test-Path "$projectDir\src\animations")) {
        New-Item -Path "$projectDir\src\animations" -ItemType Directory -Force | Out-Null
    }
}

# Ensure src directory exists
if (-not (Test-Path "$projectDir\src")) {
    New-Item -Path "$projectDir\src" -ItemType Directory -Force | Out-Null
}

# Generate animation files
Write-Host "$GREEN""🎨 Generating $($Animations.Count) animation(s)...$NC"

$animationImports = @()
$compositions = @()
$animationIndex = 1

foreach ($animTheme in $Animations) {
    $safeName = $animTheme -replace '[^a-zA-Z0-9]', '' -replace '(?=[A-Z])', ' ' | ForEach-Object { ($_ -split '\s+' | Select-Object -First 3) -join '' }
    if ([string]::IsNullOrEmpty($safeName)) { $safeName = "Animation$animationIndex" }
    $fileName = ($safeName.Substring(0, [Math]::Min(20, $safeName.Length))) + $animationIndex
    $PascalName = (($fileName -split '\s*[-_\s]+\s*' | ForEach-Object { $_.substring(0,1).toupper() + $_.substring(1).tolower() }) -join '')
    
    Write-Host "   [$animationIndex/$($Animations.Count)] $animTheme -> $PascalName"

    $animationImports += "import { $PascalName } from './animations/$PascalName';"
    
    $fps = 30
    $duration = 150
    $width = 1920
    $height = 1080
    
    # Generate theme-specific animation code
    $animationCode = Generate-AnimationCode -Theme $animTheme -Name $PascalName -Fps $fps -Duration $duration -Width $width -Height $height
    
    Set-Content -Path "$projectDir\src\animations\$PascalName.tsx" -Value $animationCode -Encoding UTF8

    $compositions += @"
    <Composition
      id="$PascalName"
      component={$PascalName}
      durationInFrames={$duration}
      fps={$fps}
      width={$width}
      height={$height}
    />
"@
    
    $animationIndex++
}

# Create or update Root.tsx
$rootCode = @"
import { Composition, registerRoot } from 'remotion';
import React from 'react';
$($animationImports -join "`n")

const Root: React.FC = () => {
  return (
    <>
$($compositions -join "`n")
    </>
  );
};

registerRoot(Root);
"@

Set-Content -Path "$projectDir\src\index.tsx" -Value $rootCode -Encoding UTF8
Set-Content -Path "$projectDir\src\Root.tsx" -Value $rootCode -Encoding UTF8

# Create animations index
$animationsIndexCode = $animationImports -replace ' from.*', '' -join ", "
Set-Content -Path "$projectDir\src\animations\index.ts" -Value "export { $animationsIndexCode };" -Encoding UTF8

# Install dependencies if new project
if ($isNewProject) {
    Write-Host "$GREEN""📦 Installing dependencies...$NC"
    Set-Location -Path $projectDir
    npm install --legacy-peer-deps 2>&1 | Out-Null
}

# Open in editor
Write-Host "$GREEN""💻 Opening in $Editor...$NC"
switch ($Editor.ToLower()) {
    "cursor" { cursor $projectDir }
    "vscode" { code $projectDir }
    default { code $projectDir }
}

# Start preview server
Write-Host "$GREEN""🚀 Starting preview server...$NC"

$retryCount = 0
$currentPort = $Port
$serverStarted = $false

while ($retryCount -lt $MAX_RETRIES -and -not $serverStarted) {
    Write-Host "$BLUE""   Attempt $($retryCount + 1)/$MAX_RETRIES on port $currentPort...$NC"

    # Kill any process on the port
    $existingProcess = Get-NetTCPConnection -LocalPort $currentPort -ErrorAction SilentlyContinue
    if ($existingProcess) {
        $processId = $existingProcess.OwningProcess
        Stop-Process -Id $processId -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 1
    }

    # Start preview in background
    $logFile = "$env:TEMP\remotionmax-preview-$currentPort.log"
    $process = Start-Process -FilePath "npx" -ArgumentList "remotion preview --port $currentPort" -WorkingDirectory $projectDir -PassThru -RedirectStandardOutput $logFile -WindowStyle Hidden

    # Wait for server to start
    Start-Sleep -Seconds 15

    # Check if server is responding
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:$currentPort" -TimeoutSec 5 -ErrorAction SilentlyContinue
        if ($response.StatusCode -eq 200) {
            $serverStarted = $true
            Write-Host "$GREEN""✅ Server is responding!$NC"
        }
    } catch {
        Write-Host "$RED""❌ Server not responding properly$NC"
    }

    if (-not $serverStarted) {
        $retryCount++
        if ($retryCount -lt $MAX_RETRIES) {
            $currentPort++
            Write-Host "$YELLOW""   Trying new port: $currentPort$NC"
        }
    }
}

if (-not $serverStarted) {
    Write-Host "$RED""❌ Failed after $MAX_RETRIES attempts$NC"
    Write-Host "$BLUE""   Check log: $logFile$NC"
    exit 1
}

Write-Host "$BLUE""⏳ Waiting for Remotion to compile your animation(s)...$NC"
$compileWait = 0
while ($compileWait -lt 30) {
    Start-Sleep -Seconds 2
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:$currentPort" -TimeoutSec 5 -ErrorAction SilentlyContinue
        if ($response.Content -match "remotion" -or $response.Content -match "Remotion") {
            Write-Host "$GREEN""✅ Compilation complete!$NC"
            break
        }
    } catch {}
    $compileWait += 2
    Write-Host "$BLUE""   Still compiling... ($compileWait/30s)$NC"
}

# Get local IP
$localIP = (Get-NetIPAddress -InterfaceAlias "Wi-Fi" -AddressFamily IPv4 -ErrorAction SilentlyContinue).IPAddress
if ([string]::IsNullOrEmpty($localIP)) {
    $localIP = "localhost"
}

# Open browser
Write-Host "$GREEN""🌐 Opening preview in browser...$NC"
Start-Sleep -Seconds 1
Start-Process -FilePath "http://localhost:$currentPort"

Write-Host ""
Write-Host "$CYAN""━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
Write-Host "$GREEN""✅ Animation Studio Ready!$NC"
Write-Host "$CYAN""━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
Write-Host ""
Write-Host "   ${PURPLE}📁 Location:${NC} $FullPath"
Write-Host "   ${PURPLE}💻 Editor:${NC} $Editor (should be open)"
Write-Host "   ${PURPLE}🔗 Preview:${NC} http://localhost:$currentPort"
Write-Host "   ${PURPLE}🌐 Network:${NC} http://$localIP`:$currentPort"
Write-Host ""
Write-Host "$YELLOW""   Animations created: $($Animations.Count)$NC"
$Animations | ForEach-Object { Write-Host "      - $_" }
Write-Host ""
Write-Host "$YELLOW""   Edit src\animations\*.tsx to customize animations!$NC"
Write-Host ""
Write-Host "$CYAN""━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
Write-Host ""
Write-Host "$BLUE""   Useful commands:$NC"
Write-Host "   - List: npx remotion compositions"
Write-Host "   - Render: npx remotion render <CompositionId> out.mp4"
Write-Host "   - Render all: npx remotion render"
Write-Host "   - GIF: npx remotion render <Id> out.gif --codec=gif"
Write-Host "   - Logs: Get-Content $logFile -Wait"
Write-Host ""


# Helper function to generate animation code based on theme
function Generate-AnimationCode {
    param(
        [string]$Theme,
        [string]$Name,
        [int]$Fps,
        [int]$Duration,
        [int]$Width,
        [int]$Height
    )
    
    $themeLower = $Theme.ToLower()
    
    # Determine animation style based on theme keywords
    $style = "neon"
    if ($themeLower -match "pixel|retro|8-bit") { $style = "pixel" }
    elseif ($themeLower -match "glitch|corrupt") { $style = "glitch" }
    elseif ($themeLower -match "particle|firework") { $style = "particle" }
    elseif ($themeLower -match "wave|text|style") { $style = "wave" }
    elseif ($themeLower -match "geometric|shape") { $style = "geometric" }
    
    switch ($style) {
        "pixel" {
            return @"
import React from 'react';
import { useCurrentFrame, interpolate, spring, AbsoluteFill } from 'remotion';

const PIXEL_SIZE = 8;

const { $Name }: React.FC = () => {
  const frame = useCurrentFrame();
  const { width, height } = { width: $Width, height: $Height };

  const scale = spring({ fps: $Fps, frame, config: { damping: 10, stiffness: 100 } });
  const opacity = interpolate(frame, [0, 30, $Duration - 30, $Duration], [0, 1, 1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <AbsoluteFill style={{ backgroundColor: '#0a0a0f', overflow: 'hidden' }}>
      {/* Pixel grid background */}
      {Array.from({ length: 120 }).map((_, i) => (
        <div
          key={`grid-${i}`}
          style={{
            position: 'absolute',
            left: (i % 20) * $PIXEL_SIZE * 4,
            top: Math.floor(i / 20) * $PIXEL_SIZE * 4 + (frame % 40),
            width: $PIXEL_SIZE,
            height: $PIXEL_SIZE,
            backgroundColor: '#1a1a2e',
            opacity: 0.5,
          }}
        />
      ))}

      {/* Main title */}
      <div
        style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: \`translate(-50%, -50%) scale(\${scale})\`,
          opacity,
        }}
      >
        <div
          style={{
            fontFamily: 'monospace',
            fontSize: 120,
            fontWeight: 'bold',
            color: '#fff',
            textShadow: '0 0 20px #ff6b9d, 0 0 40px #c44569',
            letterSpacing: 8,
          }}
        >
          EMOWOWO
        </div>
      </div>

      {/* Floating pixels */}
      {Array.from({ length: 30 }).map((_, i) => (
        <div
          key={`pixel-${i}`}
          style={{
            position: 'absolute',
            left: (i * 137 + frame * 2) % width,
            top: (i * 89 + Math.sin(frame * 0.05 + i) * 50) % height,
            width: $PIXEL_SIZE,
            height: $PIXEL_SIZE,
            backgroundColor: ['#ff6b9d', '#00d4aa', '#f8b500', '#6c5ce7'][i % 4],
            opacity: 0.8,
            boxShadow: \`0 0 10px ['#ff6b9d', '#00d4aa', '#f8b500', '#6c5ce7'][i % 4]\`,
          }}
        />
      ))}
    </AbsoluteFill>
  );
};

export { $Name };
"@
        }
        
        "glitch" {
            return @"
import React from 'react';
import { useCurrentFrame, interpolate, spring, AbsoluteFill } from 'remotion';

const { $Name }: React.FC = () => {
  const frame = useCurrentFrame();
  const { width, height } = { width: $Width, height: $Height };

  const glitchX = interpolate(frame, [0, 5, 10, 15, 20], [0, -10, 5, -5, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const glitchY = interpolate(frame, [0, 5, 10, 15, 20], [0, 5, -3, 2, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  const rgbSplit = interpolate(frame, [0, $Duration], [0, 1]) > 0.5;

  return (
    <AbsoluteFill style={{ backgroundColor: '#0a0a0f', overflow: 'hidden' }}>
      {/* RGB split effect */}
      {rgbSplit && (
        <>
          <div
            style={{
              position: 'absolute',
              top: '50%',
              left: '50%',
              transform: \`translate(-50%, -50%) translate(\${glitchX - 3}px, \${glitchY}px)\`,
              fontFamily: 'monospace',
              fontSize: 120,
              fontWeight: 'bold',
              color: '#ff0000',
              opacity: 0.8,
            }}
          >
            EMOWOWO
          </div>
          <div
            style={{
              position: 'absolute',
              top: '50%',
              left: '50%',
              transform: \`translate(-50%, -50%) translate(\${glitchX + 3}px, \${glitchY}px)\`,
              fontFamily: 'monospace',
              fontSize: 120,
              fontWeight: 'bold',
              color: '#00ffff',
              opacity: 0.8,
            }}
          >
            EMOWOWO
          </div>
        </>
      )}

      {/* Main text */}
      <div
        style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: \`translate(-50%, -50%) translate(\${glitchX}px, \${glitchY}px)\`,
          fontFamily: 'monospace',
          fontSize: 120,
          fontWeight: 'bold',
          color: '#ffffff',
          textShadow: '0 0 30px #ff6b9d',
        }}
      >
        EMOWOWO
      </div>

      {/* Scanlines */}
      {Array.from({ length: 50 }).map((_, i) => (
        <div
          key={`scan-${i}`}
          style={{
            position: 'absolute',
            top: i * 22,
            left: 0,
            right: 0,
            height: 2,
            backgroundColor: 'rgba(255,255,255,0.03)',
          }}
        />
      ))}

      {/* Glitch blocks */}
      {frame > 10 && frame < 30 && Array.from({ length: 5 }).map((_, i) => (
        <div
          key={`glitch-${i}`}
          style={{
            position: 'absolute',
            left: Math.random() * width,
            top: Math.random() * height,
            width: 50 + Math.random() * 100,
            height: 10,
            backgroundColor: ['#ff6b9d', '#00d4aa', '#f8b500'][i % 3],
            opacity: 0.8,
          }}
        />
      ))}
    </AbsoluteFill>
  );
};

export { $Name };
"@
        }
        
        "particle" {
            return @"
import React from 'react';
import { useCurrentFrame, interpolate, spring, AbsoluteFill } from 'remotion';

const { $Name }: React.FC = () => {
  const frame = useCurrentFrame();
  const { width, height } = { width: $Width, height: $Height };

  return (
    <AbsoluteFill style={{ backgroundColor: '#0a0a0f', overflow: 'hidden' }}>
      {/* Particle field */}
      {Array.from({ length: 80 }).map((_, i) => {
        const x = (i * 137 + frame * 2) % width;
        const y = (i * 89 + Math.sin(frame * 0.03 + i * 0.5) * 100) % height;
        const size = 4 + (i % 6);
        const color = ['#ff6b9d', '#c44569', '#ff6b9d', '#fff', '#00d4aa'][i % 5];
        
        return (
          <div
            key={`particle-${i}`}
            style={{
              position: 'absolute',
              left: x,
              top: y,
              width: size,
              height: size,
              backgroundColor: color,
              borderRadius: '50%',
              boxShadow: \`0 0 \${size * 3}px \${color}\`,
              opacity: 0.6 + Math.sin(frame * 0.1 + i) * 0.3,
            }}
          />
        );
      })}

      {/* Central glow */}
      <div
        style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          fontFamily: 'monospace',
          fontSize: 80,
          fontWeight: 'bold',
          color: '#fff',
          textShadow: '0 0 50px #ff6b9d, 0 0 100px #c44569',
          letterSpacing: 12,
        }}
      >
        EMOWOWO
      </div>

      {/* Orbiting rings */}
      {Array.from({ length: 3 }).map((_, i) => (
        <div
          key={`ring-${i}`}
          style={{
            position: 'absolute',
            top: '50%',
            left: '50%',
            width: 300 + i * 100,
            height: 300 + i * 100,
            borderRadius: '50%',
            border: \`2px solid rgba(255, 107, 157, \${0.3 - i * 0.1})\`,
            transform: \`translate(-50%, -50%) rotate(\${frame * (1 + i * 0.5)}deg)\`,
          }}
        />
      ))}
    </AbsoluteFill>
  );
};

export { $Name };
"@
        }
        
        "wave" {
            return @"
import React from 'react';
import { useCurrentFrame, interpolate, spring, AbsoluteFill } from 'remotion';

const { $Name }: React.FC = () => {
  const frame = useCurrentFrame();
  const { width, height } = { width: $Width, height: $Height };
  const letters = 'EMOWOWO'.split('');

  return (
    <AbsoluteFill style={{ backgroundColor: '#0a0a1a', overflow: 'hidden' }}>
      {/* Wave text */}
      <div
        style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          display: 'flex',
          gap: 8,
        }}
      >
        {letters.map((letter, i) => {
          const waveOffset = Math.sin(frame * 0.1 + i * 0.5) * 20;
          const scale = 1 + Math.sin(frame * 0.08 + i * 0.3) * 0.1;
          const colors = ['#ff6b9d', '#c44569', '#f8b500', '#00d4aa', '#6c5ce7', '#fd79a8', '#a29bfe'];
          
          return (
            <div
              key={i}
              style={{
                fontFamily: 'monospace',
                fontSize: 100,
                fontWeight: 'bold',
                color: colors[i % colors.length],
                transform: \`translateY(\${waveOffset}px) scale(\${scale})\`,
                textShadow: \`0 0 30px \${colors[i % colors.length]}\`,
              }}
            >
              {letter}
            </div>
          );
        })}
      </div>

      {/* Wave background lines */}
      {Array.from({ length: 20 }).map((_, i) => {
        const y = (i / 20) * height;
        const offset = Math.sin(frame * 0.05 + i * 0.3) * 30;
        
        return (
          <div
            key={`wave-${i}`}
            style={{
              position: 'absolute',
              top: y,
              left: 0,
              right: 0,
              height: 2,
              backgroundColor: '#1a1a2e',
              transform: \`translateX(\${offset}px)\`,
              opacity: 0.5,
            }}
          />
        );
      })}
    </AbsoluteFill>
  );
};

export { $Name };
"@
        }
        
        "geometric" {
            return @"
import React from 'react';
import { useCurrentFrame, interpolate, spring, AbsoluteFill } from 'remotion';

const { $Name }: React.FC = () => {
  const frame = useCurrentFrame();
  const { width, height } = { width: $Width, height: $Height };

  return (
    <AbsoluteFill style={{ backgroundColor: '#0a0a0f', overflow: 'hidden' }}>
      {/* Rotating geometric shapes */}
      {Array.from({ length: 8 }).map((_, i) => {
        const angle = (i / 8) * 360 + frame * 2;
        const radius = 200 + Math.sin(frame * 0.05 + i) * 50;
        const x = width / 2 + Math.cos(angle * Math.PI / 180) * radius;
        const y = height / 2 + Math.sin(angle * Math.PI / 180) * radius;
        const size = 40 + (i % 3) * 20;
        const rotation = frame * (2 + i * 0.5);
        const colors = ['#ff6b9d', '#00d4aa', '#f8b500', '#6c5ce7'];
        
        return (
          <div
            key={`shape-${i}`}
            style={{
              position: 'absolute',
              left: x - size / 2,
              top: y - size / 2,
              width: size,
              height: size,
              backgroundColor: colors[i % colors.length],
              transform: \`rotate(\${rotation}deg)\`,
              opacity: 0.7,
              boxShadow: \`0 0 20px \${colors[i % colors.length]}\`,
            }}
          />
        );
      })}

      {/* Central title */}
      <div
        style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          fontFamily: 'monospace',
          fontSize: 72,
          fontWeight: 'bold',
          color: '#fff',
          textShadow: '0 0 40px rgba(108, 92, 231, 0.8)',
          letterSpacing: 8,
        }}
      >
        EMOWOWO
      </div>

      {/* Connecting lines */}
      <svg
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          width: '100%',
          height: '100%',
          opacity: 0.3,
        }}
      >
        {Array.from({ length: 8 }).map((_, i) => {
          const angle1 = (i / 8) * 360;
          const angle2 = ((i + 1) / 8) * 360;
          const radius = 200;
          const x1 = width / 2 + Math.cos(angle1 * Math.PI / 180) * radius;
          const y1 = height / 2 + Math.sin(angle1 * Math.PI / 180) * radius;
          const x2 = width / 2 + Math.cos(angle2 * Math.PI / 180) * radius;
          const y2 = height / 2 + Math.sin(angle2 * Math.PI / 180) * radius;
          
          return (
            <line
              key={`line-${i}`}
              x1={x1}
              y1={y1}
              x2={x2}
              y2={y2}
              stroke="#6c5ce7"
              strokeWidth="2"
            />
          );
        })}
      </svg>
    </AbsoluteFill>
  );
};

export { $Name };
"@
        }
        
        default {
            return @"
import React from 'react';
import { useCurrentFrame, interpolate, spring, AbsoluteFill } from 'remotion';

const { $Name }: React.FC = () => {
  const frame = useCurrentFrame();
  const { width, height } = { width: $Width, height: $Height };

  const scale = spring({ fps: $Fps, frame, config: { damping: 12, stiffness: 100 } });
  const opacity = interpolate(frame, [0, 30, $Duration - 30, $Duration], [0, 1, 1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const glow = interpolate(frame, [0, $Duration / 2, $Duration], [0, 1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <AbsoluteFill style={{ backgroundColor: '#0a0a1a', overflow: 'hidden' }}>
      {/* Background glow */}
      <div
        style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          width: 600,
          height: 600,
          background: 'radial-gradient(circle, rgba(255, 0, 255, ' + glow * 0.3 + ') 0%, transparent 70%)',
          filter: 'blur(60px)',
        }}
      />

      {/* Main title */}
      <div
        style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: \`translate(-50%, -50%) scale(\${scale})\`,
          opacity,
        }}
      >
        <div
          style={{
            fontSize: 120,
            fontFamily: 'Arial Black, sans-serif',
            fontWeight: 'bold',
            color: '#fff',
            textShadow: \`0 0 30px rgba(255, 0, 255, \${0.8 + glow * 0.2}), 0 0 60px rgba(0, 255, 255, \${0.6 + glow * 0.2})\`,
            letterSpacing: 12,
          }}
        >
          EMOWOWO
        </div>
      </div>

      {/* Floating particles */}
      {Array.from({ length: 40 }).map((_, i) => {
        const x = (i * 137 + frame * 2) % width;
        const y = (i * 89 + Math.sin(frame * 0.05 + i) * 80) % height;
        
        return (
          <div
            key={`particle-${i}`}
            style={{
              position: 'absolute',
              left: x,
              top: y,
              width: 4,
              height: 4,
              backgroundColor: i % 2 === 0 ? '#ff00ff' : '#00ffff',
              borderRadius: '50%',
              opacity: 0.6,
              boxShadow: i % 2 === 0 ? '0 0 10px #ff00ff' : '0 0 10px #00ffff',
            }}
          />
        );
      })}
    </AbsoluteFill>
  );
};

export { $Name };
"@
        }
    }
}