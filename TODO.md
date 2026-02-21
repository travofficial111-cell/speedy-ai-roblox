# Speedynetwork Website VPS Hosting Setup

## Current Status: Configuration Updated - Ready for Deployment

## Target URL: https://speedynetwork.base44.app/Home

## What Was Done:

### ✅ Updated setup_vps.sh
- nginx server_name configured to: `speedynetwork.base44.app`
- Proxy configuration to route traffic to backend on port 5000

### ✅ Updated deploy.sh
- Deployment script ready for Flask backend deployment

### ✅ Updated flask-app.service
- Systemd service configuration verified

## To Deploy the Website to Your VPS:

1. **Run setup_vps.sh** on your server (if nginx not yet configured):
   
```
bash
   chmod +x setup_vps.sh
   ./setup_vps.sh
   
```

2. **Deploy the website/backend**:
   
```
bash
   ./deploy.sh YOUR_SERVER_IP
   
```

3. **Set up SSL** (optional but recommended):
   
```
bash
   sudo certbot --nginx -d speedynetwork.base44.app -d www.speedynetwork.base44.app
   
```

4. **Make sure your DNS is pointing to your VPS IP**

## Pterodactyl Panel - Gradient Theme

### Created Files:
- `pterodactyl-gradient-theme.css` - Full gradient theme CSS for Pterodactyl
- `apply_pterodactyl_theme.sh` - Installation script to apply theme on VPS
- `install_pterodactyl_codespace.sh` - Installation script for Codespace (experimental)

### To Install Pterodactyl on Codespace (Experimental):
```
bash
chmod +x install_pterodactyl_codespace.sh
sudo ./install_pterodactyl_codespace.sh
```
Then access at: http://localhost:8080

### To Install Pterodactyl on VPS:
Follow the official guide: https://pterodactyl.io/project/introduction.html

### To Apply Gradient Theme (After Pterodactyl is installed):
```
bash
   chmod +x apply_pterodactyl_theme.sh
   sudo ./apply_pterodactyl_theme.sh
```

### Theme Features:
- 🌈 Purple-blue gradient header and navbar
- 🎨 Dark theme with gradient accents
- 🚀 "Speedy Network Hosting" branding
- ✨ Animated gradient effects
- 🔷 Custom scrollbar styling

## Notes:
- The website should be accessible at https://speedynetwork.base44.app/Home after deployment
- If you have static HTML files for the website, they should be placed in /var/www/flask-app/ or a separate directory
- The nginx config routes traffic to port 5000 where the Flask app runs
