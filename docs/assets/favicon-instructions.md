# Adding The Modern Milkman Favicon

To use the same favicon as themodernmilkman.co.uk:

1. **Download the favicon files**:
   - Visit https://www.themodernmilkman.co.uk
   - Right-click on the favicon in the browser tab
   - Select "Save Image As" (or use browser developer tools to locate the favicon files)
   - Alternatively, use a tool like https://www.genfavicon.com/extract-website-favicon to extract them

2. **Place the files in this directory**:
   - Save the favicon.ico to this directory
   - Also save any additional icon formats like favicon.png or apple-touch-icon.png

3. **The current configuration already includes**:
   - References to favicon.png in the _includes/head-custom.html file
   - If the favicon has a different name, update this reference

4. **If additional formats are available, add them to _includes/head-custom.html**:
   ```html
   <link rel="icon" type="image/x-icon" href="{{ '/assets/favicon.ico' | relative_url }}">
   <link rel="icon" type="image/png" sizes="32x32" href="{{ '/assets/favicon-32x32.png' | relative_url }}">
   <link rel="icon" type="image/png" sizes="16x16" href="{{ '/assets/favicon-16x16.png' | relative_url }}">
   <link rel="apple-touch-icon" sizes="180x180" href="{{ '/assets/apple-touch-icon.png' | relative_url }}">
   ```