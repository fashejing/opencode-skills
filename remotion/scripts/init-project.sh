#!/bin/bash
# Quick init script for new Remotion projects

PROJECT_NAME=${1:-"my-video"}

echo "🎬 Creating Remotion project: $PROJECT_NAME"
npx create-video@latest "$PROJECT_NAME" --template=hello-world

echo "✅ Project created at ./$PROJECT_NAME"
echo "📁 cd $PROJECT_NAME"
echo "▶️  npm start (to preview)"
echo "🎥 npx remotion render (to render video)"
