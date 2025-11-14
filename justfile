# Hugo Blog Justfile
# Common commands for managing your Hugo blog

# Default recipe - show all available commands
default:
    @just --list

# Run the Hugo development server
# This will start a local server at http://localhost:1313
# Press Ctrl+C to stop the server
serve:
    @echo "🚀 Starting Hugo development server..."
    @echo "📝 Drafts are enabled - unpublished posts will be visible"
    @echo "🌐 Open http://localhost:1313 in your browser"
    @hugo server -D

# Build the production site
# Outputs to the 'public' directory
build:
    @echo "🏗️  Building Hugo site..."
    @hugo
    @echo "✅ Build complete! Output in 'public' directory"

# Create a new blog post
# Usage: just new "My Post Title"
# This will create a new post in content/posts/ with timestamp-based folder name
new name:
    @echo "📝 Creating new post: {{name}}"
    @SLUG=$$(echo "{{name}}" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g'); \
    TIMESTAMP=$$(date +%s%3N); \
    DATE=$$(date +%Y-%m-%d); \
    DIR="content/posts/$$TIMESTAMP-$$SLUG"; \
    mkdir -p "$$DIR"; \
    echo "---" > "$$DIR/index.md"; \
    echo "title: \"{{name}}\"" >> "$$DIR/index.md"; \
    echo "date: $$DATE" >> "$$DIR/index.md"; \
    echo "draft: true" >> "$$DIR/index.md"; \
    echo "description: \"\"" >> "$$DIR/index.md"; \
    echo "tags: []" >> "$$DIR/index.md"; \
    echo "---" >> "$$DIR/index.md"; \
    echo "" >> "$$DIR/index.md"; \
    echo "Write your content here..." >> "$$DIR/index.md"; \
    echo "✅ Created new post at: $$DIR/index.md"; \
    echo "📝 Edit the file to add your content"

# Update the Blowfish theme to the latest version
update-theme:
    @echo "🔄 Updating Blowfish theme..."
    @git submodule update --remote themes/blowfish
    @echo "✅ Theme updated!"
    @echo "💡 Don't forget to commit: git add themes/blowfish && git commit -m 'Update theme'"

# Format and lint (placeholder - customize based on your needs)
# If you have specific formatting tools, add them here
format:
    @echo "🎨 Formatting code..."
    @echo "⚠️  No formatter configured. Add your formatting commands here."
    @echo "💡 Common options: prettier, gofmt, etc."

# Clean build artifacts
clean:
    @echo "🧹 Cleaning build artifacts..."
    @rm -rf public resources/_gen
    @echo "✅ Clean complete!"

# Show Hugo version
version:
    @hugo version

# Initialize git submodules (if needed)
init-submodules:
    @echo "📦 Initializing git submodules..."
    @git submodule update --init --recursive
    @echo "✅ Submodules initialized!"

