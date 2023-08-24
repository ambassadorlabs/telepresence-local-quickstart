$ErrorActionPreference = "Stop"

try {
    Write-Output "Deleting kind-telepresence-quickstart cluster"
    kind delete cluster -n telepresence-quickstart
} catch {
    Write-Error "Error deleting kind cluster: $_"
}

try {
    Write-Output "Removing kind binary installed at c:\Windows\system32\kind.exe"
    Remove-Item c:\Windows\system32\kind.exe
} catch {
    Write-Error "Error removing kind binary: $_"
}
