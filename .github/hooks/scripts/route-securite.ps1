# Hook postToolUse : rappelle l'appel a Antoine quand un livrable d'architecture
# (ARCHITECTURE.md, fichier ADR*.md ou contexte-technique.md) contient un mot-cle de securite.
$ErrorActionPreference = 'Stop'

function Normalize([string]$text) {
    $decomposed = $text.Normalize([Text.NormalizationForm]::FormD)
    $plain = [Text.StringBuilder]::new()
    foreach ($c in $decomposed.ToCharArray()) {
        if ([Globalization.CharUnicodeInfo]::GetUnicodeCategory($c) -ne 'NonSpacingMark') { [void]$plain.Append($c) }
    }
    return $plain.ToString().ToLowerInvariant()
}

function Get-Strings($node) {
    if ($node -is [string]) { $node; return }
    if ($null -eq $node -or $node -is [ValueType]) { return }
    if ($node -is [System.Collections.IEnumerable]) { foreach ($i in $node) { Get-Strings $i }; return }
    foreach ($p in $node.PSObject.Properties) { Get-Strings $p.Value }
}

function Get-LocalFile([string]$path, [string]$root) {
    $full = [IO.Path]::GetFullPath($(if ([IO.Path]::IsPathRooted($path)) { $path } else { Join-Path $root $path }))
    $prefix = $root.TrimEnd([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar
    $comparison = if ([IO.Path]::DirectorySeparatorChar -eq '\') { [StringComparison]::OrdinalIgnoreCase } else { [StringComparison]::Ordinal }
    if (-not $full.StartsWith($prefix, $comparison)) { throw 'Chemin hors du depot refuse.' }

    $current = $full
    while ($current.Length -ge $root.Length) {
        $item = Get-Item -LiteralPath $current -Force -ErrorAction SilentlyContinue
        if ($item -and ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) { throw 'Lien symbolique ou jonction refuse.' }
        if ($current.Equals($root, $comparison)) { break }
        $current = Split-Path -Parent $current
        if (-not $current) { break }
    }
    if (Test-Path -LiteralPath $full -PathType Leaf) { return $full }
}

$keywords = @('base de donnees', 'api externe', 'authentification', 'donnees personnelles')
$documentPattern = '(?i)(^|[\\/])(ARCHITECTURE\.md|ADR[^\\/\r\n]*\.md|contexte-technique\.md|[a-z][a-z0-9]*-\d{3}(?:[ -][^\\/\r\n]*)?\.md)$'

try {
    $payload = [Console]::In.ReadToEnd() | ConvertFrom-Json
    $root = [IO.Path]::GetFullPath($(if ($payload.cwd) { $payload.cwd } else { (Get-Location).Path }))
    $root = $root.TrimEnd([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar

    # Harness Copilot (postToolUse) : toolArgs ; format compatible VS Code / Local : tool_input.
    $toolArgs = if ($null -ne $payload.toolArgs) { $payload.toolArgs } else { $payload.tool_input }
    if ($toolArgs -is [string] -and $toolArgs.TrimStart().StartsWith('{')) {
        try { $toolArgs = $toolArgs | ConvertFrom-Json } catch { }
    }

    $candidates = foreach ($s in (Get-Strings $toolArgs)) {
        if ($s.Trim() -match $documentPattern) { $s.Trim() }
        foreach ($m in [regex]::Matches($s, '(?im)^\*\*\* (?:Add|Update) File: (.+)$')) {
            $p = $m.Groups[1].Value.Trim()
            if ($p -match $documentPattern) { $p }
        }
    }

    $reasons = @()
    foreach ($path in ($candidates | Select-Object -Unique)) {
        $full = Get-LocalFile $path $root
        if (-not $full) { continue }

        $content = Get-Content -LiteralPath $full -Raw -Encoding UTF8
        $normalized = Normalize $content
        $found = $keywords | Where-Object { $normalized.Contains($_) }
        if (-not $found) { continue }

        $folder = Split-Path -Parent $full
        $hasReviewTrace = $normalized.Replace([string][char]0x2019, "'") -match "(?m)^[ \t]*(?:[-*][ \t]+)?avis de securite d'antoine[ \t]*:[ \t]*\S[^\r\n]*$"
        if ($normalized.Contains('security_review.md')) {
            $reportPaths = @((Join-Path $root 'SECURITY_REVIEW.MD'), (Join-Path $folder 'SECURITY_REVIEW.MD')) | Select-Object -Unique
            foreach ($reportPath in $reportPaths) {
                $report = Get-LocalFile $reportPath $root
                if ($report -and -not [string]::IsNullOrWhiteSpace((Get-Content -LiteralPath $report -Raw -Encoding UTF8))) {
                    $hasReviewTrace = $true
                    break
                }
            }
        }
        if ($hasReviewTrace) { continue }

        $reasons += "$([IO.Path]::GetFileName($full)) mentionne : $($found -join ', ')."
    }

    if ($reasons.Count -gt 0) {
        # Texte en escapes Unicode : PowerShell 5.1 lit ce fichier en ANSI.
        $action = [regex]::Unescape(" Appelle maintenant l'agent Antoine. En documentation de l'existant, demande une revue de s\u00e9curit\u00e9 du d\u00e9p\u00f4t ; garde la section S\u00e9curit\u00e9 descriptive et renvoie uniquement vers son rapport SECURITY_REVIEW.MD, sans recopier ses constats ou son avis. En conception ou en challenge, demande un avis cibl\u00e9 ; r\u00e9f\u00e9rence son rapport s'il en a produit un, ou ajoute la ligne \u00ab Avis de s\u00e9curit\u00e9 d'Antoine : \u00bb suivie de son avis cibl\u00e9. Ne pr\u00e9sente jamais un rapport comme disponible ni un avis comme obtenu sans l'avoir v\u00e9rifi\u00e9 ; si le relais \u00e9choue, signale-le dans le chat.")
        $reason = ($reasons -join ' ') + $action
        # additionalContext : sortie lue par le harness Copilot ; decision/reason : format Local.
        @{ additionalContext = $reason; decision = 'block'; reason = $reason } | ConvertTo-Json -Compress
    }
    exit 0
}
catch {
    [Console]::Error.WriteLine('route-securite : verification impossible ; verifier les chemins et les entrees du hook.')
    exit 2
}
