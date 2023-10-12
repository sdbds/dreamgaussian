$input_file="./data/test.png"
$save_path="test"
$process=1
$process_size=512
$gui=0

Set-Location $PSScriptRoot
.\venv\Scripts\activate

$Env:HF_HOME = "./huggingface"
$ext_args = [System.Collections.ArrayList]::new()

if ($gui) {
  [void]$ext_args.Add("gui=True")
}

if ($process) {
  python process.py $input_file --size $process_size
  $input_file=$input_file -replace ".png","_rgba.png"
}

python main.py --config configs/image.yaml input=$input_file save_path=$save_path $ext_args
python main2.py --config configs/image.yaml input=$input_file save_path=$save_path $ext_args

if (!(Test-Path -Path "videos")) {
    New-Item -ItemType Directory -Name "videos"
}

python -m kiui.render "logs/$save_path.obj" --save_video="videos/$save_path.mp4" --wogui
