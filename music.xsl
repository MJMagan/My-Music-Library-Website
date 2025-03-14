<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<head>
    <title>My Music Library</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
            line-height: 1.6;
            padding: 20px;
            margin: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }
        header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        h1 {
            color: #2d3748;
            margin-bottom: 10px;
        }
        .subtitle {
            color: #718096;
            font-size: 1.2rem;
        }
        .song-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        .song-card {
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            box-shadow: 9px 9px 16px rgba(189, 189, 189, 0.6), -9px -9px 16px rgba(255, 255, 255, 0.5);
        }
        .song-card:hover {
            transform: translateY(-5px);
            box-shadow: 12px 12px 20px rgba(189, 189, 189, 0.7), -12px -12px 20px rgba(255, 255, 255, 0.8);
        }
        .song-id {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #e2e8f0;
            color: #4a5568;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        .song-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 10px;
        }
        .artist {
            color: #4a5568;
            font-size: 1.1rem;
            margin-bottom: 15px;
        }
        .year-badge {
            display: inline-block;
            background: #ebf4ff;
            color: #4299e1;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        .albums-title {
            font-weight: bold;
            color: #4a5568;
            margin-bottom: 8px;
        }
        .albums-list {
            list-style-type: none;
            padding-left: 0;
            margin: 0;
        }
        .albums-list li {
            background: #f7fafc;
            padding: 8px 12px;
            margin-bottom: 5px;
            border-radius: 6px;
            font-size: 0.95rem;
        }
        .section {
            margin-top: 40px;
            padding: 20px;
            background: #f7fafc;
            border-radius: 12px;
        }
        .section h2 {
            color: #2d3748;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 10px;
            margin-top: 0;
        }
        .query-result {
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        .query-result ul {
            list-style-type: none;
            padding-left: 0;
        }
        .query-result li {
            padding: 8px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .query-result li:last-child {
            border-bottom: none;
        }
        footer {
            text-align: center;
            margin-top: 50px;
            color: #718096;
            font-size: 0.9rem;
        }
        /* Dark mode toggle */
        .theme-switch-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }
        .theme-switch {
            display: inline-block;
            height: 34px;
            position: relative;
            width: 60px;
        }
        .theme-switch input {
            display: none;
        }
        .slider {
            background-color: #ccc;
            bottom: 0;
            cursor: pointer;
            left: 0;
            position: absolute;
            right: 0;
            top: 0;
            transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            background-color: #fff;
            bottom: 4px;
            content: "";
            height: 26px;
            left: 4px;
            position: absolute;
            transition: .4s;
            width: 26px;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #2196F3;
        }
        input:checked + .slider:before {
            transform: translateX(26px);
        }
        .toggle-text {
            margin-left: 10px;
            font-size: 0.9rem;
        }
        
        /* Dark mode styles */
        body.dark-mode {
            background: #1a202c;
            color: #e2e8f0;
        }
        body.dark-mode .container {
            background: #2d3748;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }
        body.dark-mode header {
            border-bottom: 1px solid #4a5568;
        }
        body.dark-mode h1, 
        body.dark-mode .song-title {
            color: #e2e8f0;
        }
        body.dark-mode .subtitle,
        body.dark-mode .artist {
            color: #a0aec0;
        }
        body.dark-mode .song-card {
            background: #2d3748;
            box-shadow: 9px 9px 16px rgba(0, 0, 0, 0.3), -9px -9px 16px rgba(50, 50, 50, 0.2);
        }
        body.dark-mode .song-card:hover {
            box-shadow: 12px 12px 20px rgba(0, 0, 0, 0.4), -12px -12px 20px rgba(50, 50, 50, 0.3);
        }
        body.dark-mode .song-id {
            background: #4a5568;
            color: #e2e8f0;
        }
        body.dark-mode .year-badge {
            background: #2a4365;
            color: #90cdf4;
        }
        body.dark-mode .albums-title {
            color: #a0aec0;
        }
        body.dark-mode .albums-list li {
            background: #4a5568;
            color: #e2e8f0;
        }
        body.dark-mode .section {
            background: #4a5568;
        }
        body.dark-mode .section h2 {
            color: #e2e8f0;
            border-bottom: 2px solid #718096;
        }
        body.dark-mode .query-result {
            background: #2d3748;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        body.dark-mode .query-result li {
            border-bottom: 1px solid #4a5568;
        }
        body.dark-mode footer {
            color: #a0aec0;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="theme-switch-wrapper">
                <label class="theme-switch" for="checkbox">
                    <input type="checkbox" id="checkbox" />
                    <div class="slider"></div>
                </label>
                <div class="toggle-text">Dark Mode</div>
            </div>
            <h1>My Music Library</h1>
            <p class="subtitle">Explore your favorite songs and artists</p>
        </header>
        
        <div class="song-grid">
            <xsl:for-each select="music/song">
                <div class="song-card">
                    <div class="song-id"><xsl:value-of select="@id"/></div>
                    <div class="song-title"><xsl:value-of select="songTitle"/></div>
                    <div class="artist"><xsl:value-of select="artist"/></div>
                    <div class="year-badge"><xsl:value-of select="debutYear"/></div>
                    <div class="albums-title">Albums:</div>
                    <ul class="albums-list">
                        <xsl:for-each select="albums/album">
                            <li><xsl:value-of select="."/></li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:for-each>
        </div>
        
        <!-- XPath Query Section -->
        <div class="section">
            <h2>XPath Queries</h2>
            
            <h3>All Song Titles</h3>
            <div class="query-result">
                <ul>
                    <xsl:for-each select="music/song/songTitle">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>
            </div>
            
            <h3>Artist for the Fifth Song</h3>
            <div class="query-result">
                <xsl:value-of select="music/song[5]/artist"/>
            </div>
            
            <h3>Song with ID = 1</h3>
            <div class="query-result">
                <strong>Title:</strong> <xsl:value-of select="music/song[@id=1]/songTitle"/><br/>
                <strong>Artist:</strong> <xsl:value-of select="music/song[@id=1]/artist"/><br/>
                <strong>Year:</strong> <xsl:value-of select="music/song[@id=1]/debutYear"/><br/>
                <strong>Albums:</strong>
                <ul>
                    <xsl:for-each select="music/song[@id=1]/albums/album">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>
            </div>
        </div>
        
        <footer>
            <p>© 2023 Music Library Project | XML, XPath, and XSLT Demo</p>
        </footer>
    </div>
    
    <script>
        // Dark mode toggle functionality
        const toggleSwitch = document.querySelector('#checkbox');
        const currentTheme = localStorage.getItem('theme');
        
        if (currentTheme) {
            document.body.classList.add(currentTheme);
            if (currentTheme === 'dark-mode') {
                toggleSwitch.checked = true;
            }
        }
        
        function switchTheme(e) {
            if (e.target.checked) {
                document.body.classList.add('dark-mode');
                localStorage.setItem('theme', 'dark-mode');
            } else {
                document.body.classList.remove('dark-mode');
                localStorage.setItem('theme', '');
            }
        }
        
        toggleSwitch.addEventListener('change', switchTheme, false);
        
        // Add subtle hover animation to cards
        const songCards = document.querySelectorAll('.song-card');
        songCards.forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'translateY(-10px)';
            });
            card.addEventListener('mouseleave', () => {
                card.style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html>
</xsl:template>
</xsl:stylesheet>