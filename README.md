# Speedy AI - Roblox Studio Plugin

AI-powered plugin for Roblox Studio that generates assets using artificial intelligence. Create models, scripts, UI, buildings, terrain, NPCs, and more directly from text prompts.

## Features

- **Multiple Asset Types**: Generate Models, Buildings, Scripts, UI, Terrain, NPCs, and Chat with AI
- **Various Styles**: Realistic, Cartoon, Basic, Modern, Classic, Sci-Fi, Fantasy
- **Easy to Use**: Simply describe what you want and let AI generate it
- **Seamless Integration**: Works directly within Roblox Studio
- **Free Chat Assistant**: Get help with Roblox development without using AI credits

## Installation

### Option 1: Download from GitHub

1. Download the `SpeedyAIPluginScript.lua` file from this repository
2. Open Roblox Studio
3. Go to the **Plugins** tab in the top menu
4. Click **Load Plugin** > **From File**
5. Navigate to and select the `SpeedyAIPluginScript.lua` file
6. The Speedy AI plugin UI will appear in Roblox Studio

### Option 2: Use the Installed Plugin

If you have the plugin already installed in Roblox Studio, simply:
1. Open Roblox Studio
2. Go to the **Plugins** tab
3. Click on **Speedy AI Studio** to open the plugin

## Usage

### Generating Assets

1. **Select Asset Type**: Choose from Model, Building, Script, UI, Terrain, NPC, or Chat Assistant
2. **Choose Style**: Select Realistic, Cartoon, Basic, Modern, Classic, Sci-Fi, or Fantasy
3. **Enter Prompt**: Describe what you want to generate
4. **Generate**: Click "Generate with AI" to create your asset
5. **Use Result**: Click the button to insert the generated content into your place

### Using the Chat Assistant

The **Chat Assistant** feature lets you ask questions about Roblox development for FREE without consuming AI credits.

1. Select **Chat Assistant** from the Asset Type dropdown
2. Enter your question about Roblox scripting, building, UI design, etc.
3. Click **Generate with AI**
4. Get instant help from the built-in knowledge base

Example questions:
- "How do I create a leaderboard?"
- "How do I make a part follow the player?"
- "What's the best way to detect collisions?"

## Configuration

### Using the Cloud Backend (Default)

The plugin connects to the SpeedyAI cloud backend by default at `https://speedynetwork.base44.app`

### Using a Local Backend

If you want to run your own backend server:

1. Open `SpeedyAIPluginScript.lua` in a text editor
2. Change `local USE_LOCAL = false` to `local USE_LOCAL = true`
3. Update `local LOCAL_API_URL` to point to your local server (e.g., `http://localhost:5000`)
4. Save the file and reload the plugin in Roblox Studio

## Setting Up Your Own Backend (Optional)

If you want to host your own backend server:

1. Navigate to the `speedy-ai-backend` folder
2. Install dependencies: `pip install -r requirements.txt`
3. Set your API keys as environment variables:
   - `OPENAI_API_KEY` - Your OpenAI API key
   - `GEMINI_API_KEY` - Your Google Gemini API key
   - `ANTHROPIC_API_KEY` - Your Anthropic Claude API key
4. Run the server: `python app.py`
5. The server will start on `http://localhost:5000`

## API Endpoints

The backend provides the following endpoints:

- `POST /openai` - Generate content using OpenAI GPT
- `POST /gemini` - Generate content using Google Gemini
- `POST /hybrid` - Try multiple AI services for best result
- `POST /vibe` - Generate content using Anthropic Claude
- `POST /chat` - Get help from the built-in knowledge base (FREE)
- `GET /health` - Health check endpoint

## Plugin Interface

The plugin provides a clean, dark-themed UI with:
- Text input for describing your desired asset
- Dropdown menus for asset type and style selection
- Generate button to create AI-powered content
- Status display showing generation progress
- Result display with options to insert generated content

## Troubleshooting

### Plugin Not Loading

Make sure you're running the script as a Roblox Plugin, not as a regular Script.

### Connection Errors

If you see connection errors:
1. Check your internet connection
2. Verify the cloud backend is running
3. Try switching to local backend if you have one set up

### API Key Errors

If you see API key errors:
1. Make sure you have valid API keys set up
2. For the cloud backend, contact the administrator
3. For local backend, set your API keys in environment variables

## License

MIT License

## Support

For issues and feature requests, please open an issue on GitHub.

## Credits

Speedy AI - Making Roblox development faster and easier with AI
