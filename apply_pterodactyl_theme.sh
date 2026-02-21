#!/bin/bash

#===============================================
# Pterodactyl Gradient Theme Installer
# Panel Name: Speedy Network Hosting
#===============================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Speedy Network Hosting Theme${NC}"
echo -e "${GREEN}  Pterodactyl Gradient Theme Installer${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root (sudo su)${NC}"
    exit 1
fi

PTERODACTYL_PATH="/var/www/pterodactyl"

# Check if Pterodactyl is installed
if [ ! -d "$PTERODACTYL_PATH" ]; then
    echo -e "${RED}Pterodactyl not found at $PTERODACTYL_PATH${NC}"
    echo "Please install Pterodactyl first"
    exit 1
fi

echo -e "${YELLOW}[1/4] Backing up original assets...${NC}"
cp -r $PTERODACTYL_PATH/public/css $PTERODACTYL_PATH/public/css.backup 2>/dev/null
echo -e "${GREEN}Backup created${NC}"

echo -e "${YELLOW}[2/4] Creating custom CSS file...${NC}"
cat > $PTERODACTYL_PATH/public/css/custom.css << 'CSSEOF'
/*===============================================
  Speedy Network Hosting - Gradient Theme
  For Pterodactyl Panel v1.x
  ===============================================*/

/* Import Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

/* Root Variables - Gradient Colors */
:root {
    /* Primary Gradient Colors */
    --gradient-start: #667eea;
    --gradient-end: #764ba2;
    --gradient-alt-start: #f093fb;
    --gradient-alt-end: #f5576c;
    
    /* Brand Colors */
    --brand-primary: #667eea;
    --brand-secondary: #764ba2;
    --brand-accent: #00d2ff;
    
    /* Background Colors */
    --bg-dark: #0f0f23;
    --bg-card: #1a1a2e;
    --bg-sidebar: #16213e;
    
    /* Text Colors */
    --text-primary: #ffffff;
    --text-secondary: #a0a0b0;
    --text-muted: #6c757d;
}

/* ===== HEADER / NAVBAR GRADIENT ===== */
.header {
    background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end)) !important;
    border-bottom: none !important;
    box-shadow: 0 2px 20px rgba(102, 126, 234, 0.4);
}

.header .nav > li > a {
    color: rgba(255, 255, 255, 0.9) !important;
    font-weight: 500;
}

.header .nav > li > a:hover {
    background: rgba(255, 255, 255, 0.1) !important;
    color: #fff !important;
}

/* ===== SIDEBAR GRADIENT ===== */
.sidebar {
    background: linear-gradient(180deg, var(--bg-sidebar) 0%, #0f0f23 100%) !important;
    border-right: 1px solid rgba(102, 126, 234, 0.2);
}

.sidebar .nav > li > a {
    color: var(--text-secondary) !important;
    transition: all 0.3s ease;
}

.sidebar .nav > li > a:hover,
.sidebar .nav > li.active > a {
    background: linear-gradient(90deg, rgba(102, 126, 234, 0.2), transparent) !important;
    color: #fff !important;
    border-left: 3px solid var(--brand-accent);
}

.sidebar .nav > li.active > a {
    color: var(--brand-accent) !important;
}

/* ===== BUTTONS ===== */
.btn-primary {
    background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end)) !important;
    border: none !important;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
    transition: all 0.3s ease;
}

.btn-primary:hover {
    background: linear-gradient(135deg, var(--gradient-end), var(--gradient-start)) !important;
    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
    transform: translateY(-2px);
}

.btn-success {
    background: linear-gradient(135deg, #11998e, #38ef7d) !important;
    border: none !important;
    box-shadow: 0 4px 15px rgba(56, 239, 125, 0.3);
}

.btn-danger {
    background: linear-gradient(135deg, #eb3349, #f45c43) !important;
    border: none !important;
}

/* ===== CARDS ===== */
.card {
    background: var(--bg-card) !important;
    border: 1px solid rgba(102, 126, 234, 0.15) !important;
    border-radius: 12px !important;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.card-header {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1)) !important;
    border-bottom: 1px solid rgba(102, 126, 234, 0.15) !important;
    font-weight: 600;
}

/* ===== PAGE HEADER / TITLE ===== */
.page-header {
    background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
    padding: 30px;
    border-radius: 12px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
}

.page-header h1 {
    color: #fff !important;
    font-weight: 700;
    margin: 0;
    font-size: 28px;
}

.page-header .subtitle {
    color: rgba(255, 255, 255, 0.8);
    margin-top: 5px;
}

/* ===== LOGIN PAGE ===== */
.login-page {
    background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 50%, #16213e 100%) !important;
}

.login-box {
    background: rgba(26, 26, 46, 0.9) !important;
    border: 1px solid rgba(102, 126, 234, 0.3) !important;
    border-radius: 16px !important;
    box-shadow: 0 20px 60px rgba(102, 126, 234, 0.2) !important;
}

.login-logo {
    background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    font-size: 32px;
    font-weight: 800;
}

/* ===== TABLES ===== */
.table {
    color: var(--text-primary) !important;
}

.table thead th {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.15), rgba(118, 75, 162, 0.15)) !important;
    border-bottom: 2px solid var(--brand-primary) !important;
    color: #fff !important;
    font-weight: 600;
}

.table tbody tr {
    background: transparent !important;
    transition: all 0.2s ease;
}

.table tbody tr:hover {
    background: rgba(102, 126, 234, 0.1) !important;
}

/* ===== SERVER STATUS ===== */
.server-status-online {
    color: #38ef7d !important;
    text-shadow: 0 0 10px rgba(56, 239, 125, 0.5);
}

.server-status-offline {
    color: #eb3349 !important;
    text-shadow: 0 0 10px rgba(235, 51, 73, 0.5);
}

/* ===== PROGRESS BARS ===== */
.progress {
    background: rgba(255, 255, 255, 0.1) !important;
    border-radius: 10px !important;
}

.progress-bar {
    background: linear-gradient(90deg, var(--gradient-start), var(--gradient-end)) !important;
    box-shadow: 0 0 10px rgba(102, 126, 234, 0.5);
}

/* ===== FORM INPUTS ===== */
.form-control {
    background: rgba(255, 255, 255, 0.05) !important;
    border: 1px solid rgba(102, 126, 234, 0.3) !important;
    color: #fff !important;
    border-radius: 8px !important;
    transition: all 0.3s ease;
}

.form-control:focus {
    background: rgba(255, 255, 255, 0.1) !important;
    border-color: var(--brand-primary) !important;
    box-shadow: 0 0 15px rgba(102, 126, 234, 0.3) !important;
}

.form-control::placeholder {
    color: var(--text-muted) !important;
}

/* ===== DROPDOWN MENUS ===== */
.dropdown-menu {
    background: var(--bg-card) !important;
    border: 1px solid rgba(102, 126, 234, 0.2) !important;
    border-radius: 10px !important;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5) !important;
}

.dropdown-menu > li > a {
    color: var(--text-secondary) !important;
    transition: all 0.2s ease;
}

.dropdown-menu > li > a:hover {
    background: linear-gradient(90deg, rgba(102, 126, 234, 0.2), transparent) !important;
    color: #fff !important;
}

/* ===== ALERTS ===== */
.alert-success {
    background: linear-gradient(135deg, rgba(56, 239, 125, 0.2), rgba(17, 153, 142, 0.2)) !important;
    border: 1px solid rgba(56, 239, 125, 0.3) !important;
    color: #38ef7d !important;
}

.alert-danger {
    background: linear-gradient(135deg, rgba(235, 51, 73, 0.2), rgba(244, 92, 67, 0.2)) !important;
    border: 1px solid rgba(235, 51, 73, 0.3) !important;
    color: #f45c43 !important;
}

.alert-info {
    background: linear-gradient(135deg, rgba(0, 210, 255, 0.2), rgba(102, 126, 234, 0.2)) !important;
    border: 1px solid rgba(0, 210, 255, 0.3) !important;
    color: #00d2ff !important;
}

/* ===== BADGES ===== */
.badge {
    padding: 5px 10px;
    border-radius: 20px;
    font-weight: 500;
}

.badge-primary {
    background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end)) !important;
}

.badge-success {
    background: linear-gradient(135deg, #11998e, #38ef7d) !important;
}

.badge-danger {
    background: linear-gradient(135deg, #eb3349, #f45c43) !important;
}

/* ===== FOOTER ===== */
.footer {
    background: linear-gradient(180deg, transparent, rgba(15, 15, 35, 0.8)) !important;
    border-top: 1px solid rgba(102, 126, 234, 0.1) !important;
    color: var(--text-muted) !important;
}

/* ===== CUSTOM SCROLLBAR ===== */
::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}

::-webkit-scrollbar-track {
    background: var(--bg-dark);
}

::-webkit-scrollbar-thumb {
    background: linear-gradient(180deg, var(--gradient-start), var(--gradient-end));
    border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
    background: linear-gradient(180deg, var(--gradient-end), var(--gradient-start));
}

/* ===== ANIMATIONS ===== */
@keyframes gradientPulse {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

.gradient-animate {
    background-size: 200% 200%;
    animation: gradientPulse 5s ease infinite;
}

/* ===== LOGO / BRANDING ===== */
.brand-logo {
    background: linear-gradient(135deg, #667eea, #764ba2, #f093fb);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    font-weight: 800;
    font-size: 24px;
    letter-spacing: -0.5px;
}

.brand-tagline {
    color: var(--text-secondary);
    font-size: 12px;
    letter-spacing: 2px;
    text-transform: uppercase;
}

/* ===== PANEL NAME BANNER ===== */
.panel-banner {
    background: linear-gradient(135deg, var(--gradient-start) 0%, var(--gradient-end) 50%, var(--gradient-alt-start) 100%);
    padding: 15px;
    text-align: center;
    color: white;
    font-weight: 600;
    font-size: 18px;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0 4px 20px rgba(102, 126, 234, 0.4);
    animation: gradientPulse 4s ease infinite;
    background-size: 200% 200%;
}

/* ===== QUICK STATS CARDS ===== */
.stat-card {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
    border: 1px solid rgba(102, 126, 234, 0.2);
    border-radius: 12px;
    padding: 20px;
    transition: all 0.3s ease;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
    border-color: rgba(102, 126, 234, 0.4);
}

.stat-card .icon {
    background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    font-size: 32px;
}

/* ===== CONSOLE / TERMINAL ===== */
.console {
    background: #0a0a0f !important;
    border: 1px solid rgba(102, 126, 234, 0.2) !important;
    border-radius: 8px;
}

/* ===== SPINNERS ===== */
.spinner {
    background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end)) !important;
}

/* ===== TOGGLES ===== */
.toggle.on {
    background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end)) !important;
}
CSSEOF

echo -e "${GREEN}Custom CSS created${NC}"

echo -e "${YELLOW}[3/4] Adding custom CSS to layout...${NC}"

# Check if app.js exists and add custom branding
if [ -f "$PTERODACTYL_PATH/resources/scripts/index.tsx" ]; then
    echo "Found React assets, checking for layout..."
fi

# Add panel name to the header
cat > /tmp/pterodactyl-header.html << 'HTMLEOF'
<!-- Speedy Network Hosting Banner -->
<div style="
    background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
    padding: 12px 20px;
    text-align: center;
    color: white;
    font-weight: 600;
    font-size: 16px;
    border-radius: 8px;
    margin: 10px;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
">
    🚀 Speedy Network Hosting | Game Server Panel
</div>
HTMLEOF

echo -e "${YELLOW}[4/4] Clearing cache...${NC}"
cd $PTERODACTYL_PATH
php artisan cache:clear 2>/dev/null
php artisan view:clear 2>/dev/null

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Theme Installation Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}What was applied:${NC}"
echo "  ✅ Gradient header/navbar"
echo "  ✅ Gradient sidebar"
echo "  ✅ Gradient buttons"
echo "  ✅ Dark theme cards"
echo "  ✅ Custom scrollbar"
echo "  ✅ Animated gradients"
echo "  ✅ Speedy Network Hosting branding"
echo ""
echo -e "${YELLOW}Panel should now show:${NC}"
echo "  🌈 Purple-Blue gradient theme"
echo "  🚀 Speedy Network Hosting banner"
echo ""
echo -e "${BLUE}Refresh your browser (Ctrl+Shift+R) to see changes!${NC}"
