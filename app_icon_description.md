# Lotto Kugel 49 App Icon Design

## Design-Spezifikation:
- **Zentrale Lotto-Kugel** mit der Nummer 49
- **Hintergrund**: Dunkelblau (#1976D2) oder Lila (#7B1FA2)
- **Kugel-Design**: Realistisch mit Lichtreflexen und Schatten
- **Text**: Weiße "49" in der Mitte, fett
- **Stil**: Modern, clean, professionell

## Größen (Android):
- mipmap-hdpi: 72x72 px
- mipmap-mdpi: 48x48 px  
- mipmap-xhdpi: 96x96 px
- mipmap-xxhdpi: 144x144 px
- mipmap-xxxhdpi: 192x192 px

## Alternative: Einfache SVG-Version
```xml
<svg width="192" height="192" viewBox="0 0 192 192">
  <defs>
    <radialGradient id="sphereGradient" cx="30%" cy="30%">
      <stop offset="0%" stop-color="#1976D2"/>
      <stop offset="70%" stop-color="#1565C0"/>
      <stop offset="100%" stop-color="#0D47A1"/>
    </radialGradient>
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feGaussianBlur in="SourceAlpha" stdDeviation="3"/> 
      <feOffset dx="2" dy="2"/>
      <feMerge> 
        <feMergeNode/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <!-- Kugel -->
  <circle cx="96" cy="96" r="80" fill="url(#sphereGradient)" filter="url(#shadow)"/>
  
  <!-- Lichtreflex -->
  <ellipse cx="60" cy="60" rx="25" ry="15" fill="white" opacity="0.3"/>
  
  <!-- Zahl 49 -->
  <text x="96" y="110" text-anchor="middle" fill="white" font-family="Arial" font-size="48" font-weight="bold">49</text>
</svg>
