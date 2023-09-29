Set-Location $PSScriptRoot

$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1

if (!(Test-Path -Path "venv")) {
    Write-Output  "Creating venv for python..."
    python -m venv venv
}
.\venv\Scripts\activate

Write-Output "Installing deps..."
pip install --upgrade -r requirements.txt -i https://mirror.baidu.com/pypi/simple

git clone --recursive https://github.com/ashawkey/diff-gaussian-rasterization
pip install ./diff-gaussian-rasterization

pip install ./simple-knn

pip install git+https://github.com/NVlabs/nvdiffrast/

pip install git+https://github.com/ashawkey/kiuikit

Write-Output "Install completed"
Read-Host | Out-Null ;
