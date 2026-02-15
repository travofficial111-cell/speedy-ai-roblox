# SpeedyAI Backend Server

A Flask backend server that connects to real AI services (OpenAI, Google Gemini, Anthropic Claude) and replaces the localhost placeholder.

## Features

- **/openai** - OpenAI GPT endpoint
- **/hybrid** - Tries multiple AI services automatically
- **/gemini** - Google Gemini endpoint
- **/vibe** - Anthropic Claude endpoint (vibe-based generation)
- **/health** - Health check endpoint

## Setup

1. **Install dependencies:**
   
```
   pip install -r requirements.txt
   
```

2. **Configure API keys:**
   - Copy `.env.example` to `.env`
   - Add your API keys:
     - **OpenAI**: https://platform.openai.com/api-keys
     - **Google Gemini**: https://aistudio.google.com/app/apikey
     - **Anthropic Claude**: https://console.anthropic.com/

3. **Run locally (for testing):**
   
```
   python app.py
   
```
   The server will run on http://localhost:5000

4. **Deploy to your website (https://speedynetwork.base44.app):**
   - Deploy this Flask app to your web hosting
   - Set the environment variables on your server
   - The plugin will connect to your deployed backend

## Roblox Plugin Configuration

The plugin is already configured to connect to:
- **URL**: https://speedynetwork.base44.app
- **Endpoint**: /openai

When you deploy this backend to your website, the plugin will automatically work with it.

## API Endpoints

### POST /openai
Generate content using OpenAI GPT.

**Request:**
```
json
{
  "prompt": "Create a simple script",
  "assistant": "Script",
  "style": "Modern"
}
```

**Response:**
```
json
{
  "type": "script",
  "source": "生成的脚本内容..."
}
```

### POST /hybrid
Automatically tries multiple AI services for best results.

### POST /gemini
Generate content using Google Gemini.

### POST /vibe
Generate content using Anthropic Claude with unique vibe.

## Environment Variables

| Variable | Description |
|----------|-------------|
| OPENAI_API_KEY | Your OpenAI API key |
| GEMINI_API_KEY | Your Google Gemini API key |
| ANTHROPIC_API_KEY | Your Anthropic Claude API key |

## Troubleshooting

If you get "connection refused" errors:
1. Make sure the server is running
2. Check that API keys are set correctly
3. Verify the server is accessible from Roblox (network/firewall issues)
