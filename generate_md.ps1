$lines = Get-Content "blog.html" -Encoding UTF8
$currentCategory = ""

foreach ($line in $lines) {
    if ($line -match '<h3><i class=".*?"></i> (.*?)</h3>') {
        $currentCategory = $matches[1]
    }
    if ($line -match '<a href="(article_\d+)\.html".*?<h4>(.*?)</h4>') {
        $filename = $matches[1] + ".md"
        $title = $matches[2]
        
        $content = @()
        $content += "---"
        $content += "title: `"$title`""
        $content += "date: 2026-05-09"
        $content += "category: `"$currentCategory`""
        $content += "layout: layouts/article.njk"
        $content += "---"
        $content += ""
        $content += "この記事は現在準備中です。更新をお待ちください。"
        
        $content | Set-Content -Path "src\blog\$filename" -Encoding UTF8
    }
}
Write-Host "Done"
