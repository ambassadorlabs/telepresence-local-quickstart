$ErrorActionPreference = "Stop"

###### Check for prerequisites
### Check to see if Docker is installed
try {
    Get-Command "docker.exe" -ErrorAction Stop | Out-Null
    Write-Output "Docker installed, moving on!"
} catch {
    Write-Error "Docker could not be found, it is a prerequisite for Kind, please install Docker at https://docs.docker.com/get-docker/"
}

### Check to see if kubectl is installed
try {
   Get-Command "kubectl" -ErrorAction Stop | Out-Null
   Write-Output "kubectl installed, moving on!"
} catch {
    Write-Error "kubectl could not be found, it is a prerequisite for this script, please install it at https://kubernetes.io/docs/tasks/tools"
}

### Check to see if Telepresence is installed
try {
    Get-Command "telepresence" -ErrorAction Stop | Out-Null
    Write-Output "Telepresence installed, moving on!"
} catch {
    Write-Error "Telepresence not installed, please install it at https://getambassador.io/docs/telepresence/latest/install"
}

######

###### Create a kind cluster
### Install kind only if they don't have kind

try {
    if ($null -ne (Get-Command "kind" -ErrorAction SilentlyContinue)) {
        Write-Output "kind already installed, moving on!"
    } else {
        Write-Output "kind not installed, installing to c:\Windows\system32\kind.exe"
        curl.exe -Lo kind.exe https://kind.sigs.k8s.io/dl/v0.20.0/kind-windows-amd64
        Move-Item .\kind.exe c:\Windows\system32\kind.exe -ErrorAction Stop
    }
} catch {
    Write-Error "Error installing kind: $_"
}

### Make sure Docker is running
try {
    Get-Process "docker" -ErrorAction Stop | Out-Null
    Write-Output "docker running, moving on!"
} catch {
    Write-Error "Docker isn't running, please start docker and then re-run the script."
}

### Create the cluster
try {
    kubectl config use-context kind-telepresence-quickstart 2> nul
    if ($true -eq $?) {
        Write-Output "telepresence-quickstart cluster already exists, moving on!"
    } else {
        Write-Output "Creating telepresence-quickstart cluster using kind"
        kind create cluster --name telepresence-quickstart
    }
} catch {
    Write-Error "Error creating the kind cluster: $_"
}

### Make sure we're using the correct context before moving on
kubectl config use-context kind-telepresence-quickstart

######

###### Install traffic manager
Write-Output "Installing Telepresence traffic manager to cluster"
try {
    telepresence helm install 2> nul
    if ($true -eq $?) {
        Write-Output "Telepresence traffic manager successfully installed!"
    }
} catch {
    Write-Error "Failed to install the Telepresence traffic manager: $_"
}

######

###### Install edgey-corp-python
try {
    kubectl apply -f .\edgey-corp-python\k8s-config\edgey-corp-web-app-no-mapping.yaml
    Write-Output "Sample app successfully installed, you're ready to go through the rest of the quickstart!"
} catch {
    Write-Error "Failed to install the sample app: $_"
}

######
