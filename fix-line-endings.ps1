# Fix line endings in all .sh files in the bin directory
$files = Get-ChildItem ./bin -Filter *.sh

foreach ($file in $files) {
    Write-Host "Fixing line endings in: $($file.Name)"
    
    # Read the file content
    $content = Get-Content $file.FullName -Raw
    
    # Replace CRLF with LF
    $content = $content -replace "`r`n", "`n"
    
    # Write back without BOM and with UTF8 encoding
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
}

Write-Host "`nDone! All .sh files now have Unix line endings (LF)."
Write-Host "Now run: docker compose build --no-cache"
