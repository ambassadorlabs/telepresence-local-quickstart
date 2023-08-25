$ErrorActionPreference = "Stop"

try {
    Write-Output "Deleting kind-telepresence-quickstart cluster"
    .\kind.exe delete cluster -n telepresence-quickstart
} catch {
    Write-Error "Error deleting kind cluster: $_"
}

try {
    Write-Output "Removing kind binary"
    Remove-Item .\kind.exe
} catch {
    Write-Error "Error removing kind binary: $_"
}
