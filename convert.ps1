$files = Get-ChildItem -Filter "article_*.html"
mkdir src\blog -Force

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Extract Title
    $title = ""
    if ($content -match '<h1 class="article-title">(.*?)</h1>') {
        $title = $matches[1]
    }
    
    # Extract Category
    $category = ""
    if ($content -match '<span class="article-category"><i class=".*?"></i>\s*(.*?)</span>') {
        $category = $matches[1]
    }
    
    # Extract Date
    $date = "2026-05-09"
    if ($content -match '<i class="far fa-clock"></i>\s*([\d\.]+)') {
        $date = $matches[1] -replace '\.', '-'
    }
    
    # Extract Body Content
    $body = ""
    if ($content -match '(?s)<main class="article-body">(.*?)<!-- Author Info -->') {
        $body = $matches[1].Trim()
    }
    
    # Markdown Frontmatter
    $mdContent = @"
---
title: "$title"
date: $date
category: "$category"
layout: layouts/article.njk
---

$body
"@
    
    $outName = $file.Name -replace '\.html$', '.md'
    $mdContent | Set-Content -Path "src\blog\$outName" -Encoding UTF8
}
Write-Output "Successfully converted $($files.Count) articles."
