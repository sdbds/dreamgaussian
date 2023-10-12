Set-Location $PSScriptRoot

$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1

if (!(Test-Path -Path "venv")) {
    Write-Output  "Creating venv for python..."
    python -m venv venv
}

if (!(Test-Path -Path "venv/Scripts/libs")) {
    $python_home = (Get-ItemProperty -Path HKLM:\SOFTWARE\Python\PythonCore\*\InstallPath)."(default)"
    Write-Host $python_home

    $python_lib = $python_home+"\libs\"

    Copy-Item $python_lib "./venv\Scripts" -Recurse
}

.\venv\Scripts\activate

Write-Output "Installing deps..."

pip install torch==2.0.1+cu118 torchvision==0.15.2+cu118 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html -i https://mirror.baidu.com/pypi/simple

pip install --upgrade -r requirements.txt -i https://mirror.baidu.com/pypi/simple

git clone --recursive https://github.com/ashawkey/diff-gaussian-rasterization
pip install ./diff-gaussian-rasterization

pip install ./simple-knn

pip install git+https://github.com/NVlabs/nvdiffrast/

pip install git+https://github.com/ashawkey/kiuikit

Write-Output "Install completed"
Read-Host | Out-Null ;
