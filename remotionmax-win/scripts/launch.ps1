# remotionmax-win - One-click animation studio (Windows PowerShell)
# Creates animation, opens editor, starts preview

param(
    [string]$Name = "",
    [string]$Theme = "",
    [string]$Editor = "",
    [string]$Template = "hello-world",
    [string]$ProjectPath = "$env:USERPROFILE\Documents\emowowo remotion",
    [int]$Port = 3456,
    [switch]$Auto
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

    if ([string]::IsNullOrEmpty($Theme)) {
        Write-Host ""
        Write-Host "$BLUE""🎨 Step 2: Animation Theme$NC"
        Write-Host "   What kind of animation do you want?"
        Write-Host "   Examples:"
        Write-Host "   - 'neon glow logo'"
        Write-Host "   - 'particle explosion'"
        Write-Host "   - 'rainbow text wave'"
        Write-Host "   - 'cyberpunk glitch'"
        Write-Host "   - 'pixel art character'"
        Write-Host ""
        $Theme = Read-Host "   Enter your animation theme"
        if ([string]::IsNullOrEmpty($Theme)) { $Theme = "neon glow logo" }
    }

    if ([string]::IsNullOrEmpty($Editor)) {
        Write-Host ""
        Write-Host "$BLUE""💻 Step 3: Choose Editor$NC"
        Write-Host "   1) Cursor (recommended)"
        Write-Host "   2) VS Code"
        Write-Host ""
        $choice = Read-Host "   Select editor (1 or 2)"
        if ($choice -eq "2") { $Editor = "vscode" } else { $Editor = "cursor" }
    }

    if ([string]::IsNullOrEmpty($Template)) {
        Write-Host ""
        Write-Host "$BLUE""📋 Step 4: Choose Template$NC"
        Write-Host "   1) hello-world (simple animation)"
        Write-Host "   2) blank (empty canvas)"
        Write-Host "   3) three-fiber (3D animations)"
        Write-Host "   4) still-images (dynamic images)"
        Write-Host ""
        $choice = Read-Host "   Select template (default: 1)"
        switch ($choice) {
            "2" { $Template = "blank" }
            "3" { $Template = "three-fiber" }
            "4" { $Template = "still-images" }
            default { $Template = "hello-world" }
        }
    }
}

# Set defaults
if ([string]::IsNullOrEmpty($Name)) { $Name = "my-animation" }
if ([string]::IsNullOrEmpty($Theme)) { $Theme = "neon glow logo" }
if ([string]::IsNullOrEmpty($Editor)) { $Editor = "cursor" }
if ([string]::IsNullOrEmpty($ProjectPath)) { $ProjectPath = "$env:USERPROFILE\Documents\emowowo remotion" }

$FullPath = "$ProjectPath\$Name"

Write-Host ""
Write-Host "$CYAN""━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
Write-Host "$GREEN""📦 Creating your animation project...$NC"
Write-Host "$CYAN""━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
Write-Host "   Project: $Name"
Write-Host "   Theme: $Theme"
Write-Host "   Editor: $Editor"
Write-Host "   Template: $Template"
Write-Host "   Path: $FullPath"
Write-Host ""

# Create project directory
$projectDir = $FullPath
if (Test-Path $projectDir) {
    Write-Host "$YELLOW""⚠️  Directory exists. Removing old project...$NC"
    Remove-Item -Path $projectDir -Recurse -Force
}

Write-Host "$GREEN""📁 Creating project structure...$NC"
New-Item -Path "$projectDir\src" -ItemType Directory -Force | Out-Null
New-Item -Path "$projectDir\public" -ItemType Directory -Force | Out-Null

# Create package.json
$packageJson = @"
{
  "name": "remotion-project",
  "version": "1.0.0",
  "description": "Created with RemotionMAX-WIN",
  "scripts": {
    "start": "remotion preview",
    "build": "remotion render MyVideo out.mp4",
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
Set-Content -Path "$projectDir\package.json" -Value $packageJson

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
Set-Content -Path "$projectDir\tsconfig.json" -Value $tsconfig

# Generate animation code based on theme
Write-Host "$GREEN""🎨 Generating animation code for: $Theme$NC"

# Create animation file
$animationCode = @"
import React from 'react';
import { useCurrentFrame, interpolate, spring, AbsoluteFill } from 'remotion';

const ThemeAnimation: React.FC = () => {
  const frame = useCurrentFrame();
  const fps = 30;

  const scale = spring({ fps, frame, config: { damping: 12, stiffness: 100 } });
  const opacity = interpolate(frame, [0, 30, 120, 150], [0, 1, 1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });
  const floatY = interpolate(frame, [0, 75, 150], [0, -20, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <AbsoluteFill style={{ backgroundColor: '#0a0a1a', justifyContent: 'center', alignItems: 'center' }}>
      <div style={{
        transform: \`scale(\${scale}) translateY(\${floatY})\`,
        opacity,
      }}>
        <div style={{
          fontSize: 100,
          fontFamily: 'Arial Black, sans-serif',
          fontWeight: 'bold',
          color: '#fff',
          textShadow: '0 0 30px rgba(255, 0, 255, 0.8), 0 0 60px rgba(0, 255, 255, 0.6)',
        }}>
          EMOWOWO
        </div>
      </div>
    </AbsoluteFill>
  );
};

export default ThemeAnimation;
"@
Set-Content -Path "$projectDir\src\ThemeAnimation.tsx" -Value $animationCode

# Create index.tsx with registerRoot
$indexCode = @"
import { Composition, registerRoot } from 'remotion';
import React from 'react';
import ThemeAnimation from './ThemeAnimation';

const Root: React.FC = () => {
  return (
    <Composition
      id="ThemeAnimation"
      component={ThemeAnimation}
      durationInFrames={150}
      fps={30}
      width={1920}
      height={1080}
    />
  );
};

registerRoot(Root);
"@
Set-Content -Path "$projectDir\src\index.tsx" -Value $indexCode

# Create public folder placeholder
"" | Out-File -FilePath "$projectDir\public\.gitkeep" -Encoding utf8

# Install dependencies
Write-Host "$GREEN""📦 Installing dependencies...$NC"
Set-Location -Path $projectDir
npm install --legacy-peer-deps 2>&1 | Out-Null

# Open in editor
Write-Host "$GREEN""💻 Opening in $Editor...$NC"
switch ($Editor.ToLower()) {
    "vscode" { code $projectDir }
    "cursor" { cursor $projectDir }
    default { cursor $projectDir }
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

Write-Host "$BLUE""⏳ Waiting for Remotion to compile your animation...$NC"
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
Write-Host "$YELLOW""   Edit src\ThemeAnimation.tsx to customize your animation!$NC"
Write-Host ""
Write-Host "$CYAN""━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
Write-Host ""
Write-Host "$BLUE""   Useful commands:$NC"
Write-Host "   - Render: npx remotion render ThemeAnimation out.mp4"
Write-Host "   - GIF: npx remotion render ThemeAnimation out.gif --codec=gif"
Write-Host "   - Logs: Get-Content $logFile -Wait"
Write-Host ""