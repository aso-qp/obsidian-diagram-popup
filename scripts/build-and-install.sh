#!/bin/bash

# Build and install obsidian-diagram-popup plugin
# Usage: ./build-and-install.sh [vault-path]
#
# If vault-path is not provided, tries:
# 1. Command argument
# 2. $OBSIDIAN_VAULT environment variable
# 3. Common default paths

set -e

# Get vault path from argument or environment variable
VAULT_PATH="${1:-$OBSIDIAN_VAULT}"

# Try common default paths if not found
if [ -z "$VAULT_PATH" ]; then
    if [ -d "/Users/aso/Obsidian/qp" ]; then
        VAULT_PATH="/Users/aso/Obsidian/qp"
    elif [ -d "$HOME/Obsidian/qp" ]; then
        VAULT_PATH="$HOME/Obsidian/qp"
    fi
fi

if [ -z "$VAULT_PATH" ]; then
    echo "❌ Error: No vault path provided"
    echo "Usage: $0 [vault-path]"
    echo "Or set OBSIDIAN_VAULT environment variable"
    exit 1
fi

if [ ! -d "$VAULT_PATH" ]; then
    echo "❌ Error: Vault path does not exist: $VAULT_PATH"
    exit 1
fi

PLUGIN_ID="mermaid-popup"
PLUGIN_DIR="$VAULT_PATH/.obsidian/plugins/$PLUGIN_ID"

echo "🔨 Building plugin..."
pnpm run build

echo "📦 Creating plugin directory..."
mkdir -p "$PLUGIN_DIR"

echo "📋 Installing files..."
cp dist/main.js dist/manifest.json styles.css "$PLUGIN_DIR/"

echo "✅ Plugin installed to: $PLUGIN_DIR"
echo ""
echo "📝 Next steps:"
echo "1. Reload Obsidian (Cmd+Shift+R or close/reopen)"
echo "2. Enable plugin in Settings → Community Plugins"
