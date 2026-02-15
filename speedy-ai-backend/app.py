"""
SpeedyAI Backend Server
A Flask backend that connects to real AI services (OpenAI, Gemini, etc.)
Replaces the localhost:5000 placeholder with actual AI capabilities.
"""

from flask import Flask, request, jsonify
import os
import requests
from flask_cors import CORS
from datetime import datetime
import json
import threading

app = Flask(__name__)
CORS(app)  # Enable CORS for Roblox plugin

# Configuration - Set these environment variables or update them here
OPENAI_API_KEY = os.environ.get('OPENAI_API_KEY', 'your-openai-api-key')
GEMINI_API_KEY = os.environ.get('GEMINI_API_KEY', 'your-gemini-api-key')
ANTHROPIC_API_KEY = os.environ.get('ANTHROPIC_API_KEY', 'your-anthropic-api-key')
BASE44_LOG_URL = os.environ.get('BASE44_LOG_URL', '')  # URL to send logs to base44

# AI Service URLs
OPENAI_API_URL = "https://api.openai.com/v1/chat/completions"
GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent"

# In-memory storage for logs (can be replaced with database later)
logs = []
logs_lock = threading.Lock()

def log_generation(endpoint, prompt, assistant, style, result, result_type):
    """Log all AI generations to memory and optionally send to base44"""
    log_entry = {
        "id": len(logs) + 1,
        "timestamp": datetime.utcnow().isoformat(),
        "endpoint": endpoint,
        "prompt": prompt,
        "assistant": assistant,
        "style": style,
        "result": result,
        "result_type": result_type
    }
    
    with logs_lock:
        logs.append(log_entry)
    
    # Send to base44 if URL is configured
    if BASE44_LOG_URL:
        try:
            requests.post(BASE44_LOG_URL, json=log_entry, timeout=5)
        except Exception as e:
            print(f"Failed to send log to base44: {e}")
    
    print(f"[LOG] {assistant} ({style}) - {endpoint} - {result_type}")

def generate_with_openai(prompt, model="gpt-3.5-turbo"):
    """Generate content using OpenAI API"""
    headers = {
        "Authorization": f"Bearer {OPENAI_API_KEY}",
        "Content-Type": "application/json"
    }
    
    data = {
        "model": model,
        "messages": [{"role": "user", "content": prompt}],
        "max_tokens": 1000
    }
    
    response = requests.post(OPENAI_API_URL, headers=headers, json=data)
    
    if response.status_code == 200:
        return response.json()["choices"][0]["message"]["content"]
    else:
        raise Exception(f"OpenAI API error: {response.text}")

def generate_with_gemini(prompt):
    """Generate content using Google Gemini API"""
    headers = {
        "Content-Type": "application/json"
    }
    
    params = {
        "key": GEMINI_API_URL
    }
    
    data = {
        "contents": [{"parts": [{"text": prompt}]}]
    }
    
    # Extract API key from URL
    api_url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key={GEMINI_API_KEY}"
    
    response = requests.post(api_url, headers=headers, json=data)
    
    if response.status_code == 200:
        return response.json()["candidates"][0]["content"]["parts"][0]["text"]
    else:
        raise Exception(f"Gemini API error: {response.text}")

def generate_with_anthropic(prompt):
    """Generate content using Anthropic Claude API"""
    headers = {
        "x-api-key": ANTHROPIC_API_KEY,
        "Content-Type": "application/json",
        "anthropic-version": "2023-06-01"
    }
    
    data = {
        "model": "claude-3-haiku-20240307",
        "max_tokens": 1000,
        "messages": [{"role": "user", "content": prompt}]
    }
    
    response = requests.post(
        "https://api.anthropic.com/v1/messages",
        headers=headers,
        json=data
    )
    
    if response.status_code == 200:
        return response.json()["content"][0]["text"]
    else:
        raise Exception(f"Anthropic API error: {response.text}")

@app.route('/openai', methods=['POST'])
def openai_endpoint():
    """OpenAI endpoint - handles /openai requests from the plugin"""
    try:
        data = request.json
        prompt = data.get('prompt', '')
        assistant = data.get('assistant', 'Script')
        style = data.get('style', 'Modern')
        
        # Combine prompt with assistant and style info
        full_prompt = f"Create a {style.lower()} {assistant.lower()} in Roblox: {prompt}"
        
        # Generate with OpenAI
        result = generate_with_openai(full_prompt)
        
        # Log the generation
        log_generation("/openai", prompt, assistant, style, result, "script")
        
        return jsonify({
            "type": "script",
            "source": result
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/hybrid', methods=['POST'])
def hybrid_endpoint():
    """Hybrid endpoint - uses multiple AI services"""
    try:
        data = request.json
        prompt = data.get('prompt', '')
        assistant = data.get('assistant', 'Script')
        style = data.get('style', 'Modern')
        
        full_prompt = f"Create a {style.lower()} {assistant.lower()} in Roblox: {prompt}"
        
        # Try OpenAI first, fallback to others
        try:
            result = generate_with_openai(full_prompt)
        except:
            try:
                result = generate_with_gemini(full_prompt)
            except:
                result = generate_with_anthropic(full_prompt)
        
        # Log the generation
        log_generation("/hybrid", prompt, assistant, style, result, "script")
        
        return jsonify({
            "type": "script",
            "source": result
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/gemini', methods=['POST'])
def gemini_endpoint():
    """Gemini endpoint - uses Google Gemini API"""
    try:
        data = request.json
        prompt = data.get('prompt', '')
        assistant = data.get('assistant', 'Script')
        style = data.get('style', 'Modern')
        
        full_prompt = f"Create a {style.lower()} {assistant.lower()} in Roblox: {prompt}"
        
        result = generate_with_gemini(full_prompt)
        
        # Log the generation
        log_generation("/gemini", prompt, assistant, style, result, "script")
        
        return jsonify({
            "type": "script",
            "source": result
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/vibe', methods=['POST'])
def vibe_endpoint():
    """Vibe coder endpoint - uses Anthropic Claude for vibe-based generation"""
    try:
        data = request.json
        prompt = data.get('prompt', '')
        assistant = data.get('assistant', 'Script')
        style = data.get('style', 'Modern')
        
        full_prompt = f"Create a {style.lower()} {assistant.lower()} in Roblox with a unique vibe: {prompt}"
        
        result = generate_with_anthropic(full_prompt)
        
        # Log the generation
        log_generation("/vibe", prompt, assistant, style, result, "script")
        
        return jsonify({
            "type": "script",
            "source": result
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Local knowledge base for Chat Assistant (free, no AI credits needed)
ROBLOX_KNOWLEDGE_BASE = {
    # Variables
    "variable": "In Roblox Luau, create variables using 'local':\n\nlocal myNumber = 10\nlocal myString = \"Hello\"\nlocal myPart = workspace.Part\n\nFor persistent data, use attributes or ReplicatedStorage.",
    
    # Functions
    "function": "To create a function:\n\nlocal function greet(player)\n    print(\"Hello, \" .. player.Name)\n    return \"Welcome!\"\nend\n\ngreet(game.Players.LocalPlayer)",
    
    # Events
    "event": "Common Roblox events:\n\n-- Touched event\npart.Touched:Connect(function(hit)\n    print(hit.Name .. \" was touched\")\nend)\n\n-- Player events\nplayer.Chatted:Connect(function(msg)\n    print(player.Name .. \" said: \" .. msg)\nend)",
    
    # Loops
    "loop": "Common loops:\n\n-- For loop\nfor i = 1, 10 do print(i) end\n\n-- While loop\nwhile true do wait() end\n\n-- ForEach\nfor _, part in pairs(workspace:GetChildren()) do print(part.Name) end",
    
    # Tables
    "table": "Tables in Luau:\n\n-- Array\nlocal colors = {\"Red\", \"Blue\"}\nprint(colors[1])\n\n-- Dictionary\nlocal data = {Name = \"Player1\", Score = 100}",
    
    # RemoteEvents
    "remote": "RemoteEvents for client-server:\n\n-- Server:\nlocal re = Instance.new(\"RemoteEvent\")\nre.Name = \"MyEvent\"\nre.Parent = ReplicatedStorage\nre.OnServerEvent:Connect(function(p, msg) print(p.Name..\": \"..msg) end)\n\n-- Client:\nReplicatedStorage.MyEvent:FireServer(\"Hello!\")",
    
    # Leaderstats
    "leaderstats": "Creating a leaderboard:\n\nlocal function createLeaderstats(player)\n    local ls = Instance.new(\"Folder\")\n    ls.Name = \"leaderstats\"\n    ls.Parent = player\n    local score = Instance.new(\"IntValue\")\n    score.Name = \"Score\"\n    score.Value = 0\n    score.Parent = ls\nend\n\ngame.Players.PlayerAdded:Connect(createLeaderstats)",
    
    # Parts
    "part": "Creating parts:\n\nlocal part = Instance.new(\"Part\")\npart.Size = Vector3.new(4, 1, 4)\npart.Position = Vector3.new(0, 5, 0)\npart.BrickColor = BrickColor.new(\"Bright red\")\npart.Anchored = true\npart.Parent = workspace",
    
    # Building
    "building": "Building tips:\n1. Use Anchored = true for stationary parts\n2. Group parts into Models\n3. Use UnionOperations for complex shapes\n4. Use PivotTo for positioning\n5. Enable Collision for interactions",
    
    # Humanoid
    "humanoid": "Working with Humanoids:\n\nlocal h = part.Parent:FindFirstChildWhichIsA(\"Humanoid\")\nif h then\n    h.Health = 100\n    h.WalkSpeed = 16\n    h.JumpPower = 50\nend",
    
    # Animation
    "animation": "Creating animations:\n1. Use Animation Editor plugin\n2. Save to ReplicatedStorage\n3. Load:\nlocal anim = Instance.new(\"Animation\")\nanim.AnimationId = \"rbxassetid://ID\"\nlocal track = humanoid:LoadAnimation(anim)\ntrack:Play()",
    
    # UI
    "ui": "Creating UI:\n\nlocal sg = Instance.new(\"ScreenGui\")\nsg.Parent = game:GetService(\"StarterGui\")\nlocal label = Instance.new(\"TextLabel\")\nlabel.Size = UDim2.new(0,200,0,50)\nlabel.Text = \"Hello!\"\nlabel.Parent = sg",
    
    # Tween
    "tween": "Using Tweens:\n\nlocal ti = TweenInfo.new(1, Enum.EasingStyle.Quad)\nlocal goal = {Position = Vector3.new(10,5,0)}\nlocal tween = game:GetService(\"TweenService\"):Create(part, ti, goal)\ntween:Play()",
    
    # Physics
    "physics": "Physics tips:\n1. Enable Collisions\n2. Use BodyGyro/BodyVelocity\n3. Use Constraints for joints\n4. Adjust CustomPhysicalProperties",
    
    # Workspace
    "workspace": "Workspace contains all objects:\n\nfor _, part in pairs(workspace:GetChildren()) do\n    if part:IsA(\"BasePart\") then print(part.Name) end\nend",
    
    # ReplicatedStorage
    "replicatedstorage": "ReplicatedStorage for shared data:\n\nlocal rs = game:GetService(\"ReplicatedStorage\")\nlocal re = Instance.new(\"RemoteEvent\")\nre.Name = \"MyEvent\"\nre.Parent = rs",
    
    # DataStore
    "datastore": "Using DataStore:\n\nlocal ds = game:GetService(\"DataStoreService\")\nlocal store = ds:GetDataStore(\"MyData\")\n\n-- Save: store:SetAsync(player.UserId, {Score=100})\n-- Load: local data = store:GetAsync(player.UserId)",
    
    # ClickDetector
    "clickdetector": "Using ClickDetector:\n\nlocal cd = Instance.new(\"ClickDetector\")\ncd.Parent = part\ncd.MouseClick:Connect(function(player)\n    print(player.Name..\" clicked!\")\nend)",
    
    # Tool
    "tool": "Creating a Tool:\n\nlocal tool = Instance.new(\"Tool\")\ntool.Name = \"MyTool\"\nlocal handle = Instance.new(\"Part\")\nhandle.Name = \"Handle\"\nhandle.Parent = tool\ntool.Parent = game:GetService(\"StarterPack\")",
    
    # Pathfinding
    "pathfinding": "Using PathfindingService:\n\nlocal ps = game:GetService(\"PathfindingService\")\nlocal path = ps:CreatePath()\npath:ComputeAsync(startPos, endPos)\nlocal waypoints = path:GetWaypoints()",
    
    # scripting
    "scripting": "Roblox scripting basics:\n1. Use 'local' for variables\n2. Use functions to organize code\n3. Connect events with :Connect()\n4. Use services like Players, Workspace\n5. Use : for methods, . for properties",
    
    # error
    "error": "Common errors:\n1. 'Attempt to index nil' - Check if object exists\n2. 'Expected x got y' - Check data types\n3. 'Unable to cast' - Use correct type\n4. 'Stack trace' - Check infinite loops",
    
    # help
    "help": "I'm your Roblox assistant! Ask me about:\n- Scripting (variables, functions, loops, tables)\n- Building (parts, models, physics)\n- UI (ScreenGui, labels, buttons)\n- Events (Touched, Clicked, Chatted)\n- Services (Pathfinding, DataStore)\n\nJust describe what you need!",
    
    # how to
    "how to": "Just tell me what you want! Like:\n- 'How do I make a part move?'\n- 'How do I detect clicks?'\n- 'How do I save data?'\n\nI'll give you the code!",
    
    # default
    "default": "I'm Speedy AI, your Roblox helper! I can help with:\n\n📝 Scripting - variables, functions, events\n🏗️ Building - parts, models, physics\n🎨 UI - ScreenGui, labels, buttons\n💾 Data - DataStore, leaderstats\n🔧 Tools - Pathfinding, animations\n\nWhat would you like help with?"
}

def find_best_match(query):
    """Find best matching response from knowledge base"""
    query = query.lower()
    
    if query in ROBLOX_KNOWLEDGE_BASE:
        return ROBLOX_KNOWLEDGE_BASE[query]
    
    best_match = None
    best_score = 0
    
    for key, response in ROBLOX_KNOWLEDGE_BASE.items():
        query_words = set(query.split())
        key_words = set(key.split())
        matches = len(query_words.intersection(key_words))
        
        if matches > best_score:
            best_score = matches
            best_match = response
    
    if best_score > 0:
        return best_match
    
    return ROBLOX_KNOWLEDGE_BASE["default"]

@app.route('/chat', methods=['POST'])
def chat_endpoint():
    """Free Chat Assistant - uses local knowledge base"""
    try:
        data = request.json
        prompt = data.get('prompt', '')
        
        if not prompt:
            return jsonify({"error": "No prompt provided"}), 400
        
        response = find_best_match(prompt)
        
        log_generation("/chat", prompt, "Chat Assistant", "N/A", response, "chat")
        
        return jsonify({
            "type": "chat",
            "response": response
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/logs', methods=['GET'])
def get_logs():
    """Retrieve all logs"""
    with logs_lock:
        return jsonify({"logs": logs, "count": len(logs)})

@app.route('/logs/count', methods=['GET'])
def get_logs_count():
    """Get statistics about logs"""
    with logs_lock:
        # Count by endpoint
        endpoint_counts = {}
        style_counts = {}
        assistant_counts = {}
        
        for log in logs:
            endpoint = log.get('endpoint', 'unknown')
            style = log.get('style', 'unknown')
            assistant = log.get('assistant', 'unknown')
            
            endpoint_counts[endpoint] = endpoint_counts.get(endpoint, 0) + 1
            style_counts[style] = style_counts.get(style, 0) + 1
            assistant_counts[assistant] = assistant_counts.get(assistant, 0) + 1
        
        return jsonify({
            "total": len(logs),
            "by_endpoint": endpoint_counts,
            "by_style": style_counts,
            "by_assistant": assistant_counts
        })

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({"status": "ok", "message": "SpeedyAI backend is running"})

    
@app.route('/', methods=['GET'])
def index():
    """Root endpoint"""
    return jsonify({
        "message": "SpeedyAI Backend Server",
        "endpoints": {
            "/openai": "OpenAI GPT endpoint",
            "/hybrid": "Hybrid AI (tries multiple services)",
            "/gemini": "Google Gemini endpoint",
            "/vibe": "Anthropic Claude endpoint",
            "/health": "Health check"
        }
    })

if __name__ == '__main__':
    print("Starting SpeedyAI Backend Server...")
    print("Configure your API keys in app.py or set environment variables:")
    print("  - OPENAI_API_KEY")
    print("  - GEMINI_API_KEY") 
    print("  - ANTHROPIC_API_KEY")
    print("\nServer running on http://localhost:5000")
    app.run(host='0.0.0.0', port=5000, debug=True)
