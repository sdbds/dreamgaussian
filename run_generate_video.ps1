$model="tmp.glb"
$save_path="tmp"
$process=0
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
}

#python main.py --config configs/image.yaml input=data/anya_rgba.png save_path=$save_path $ext_args
#python main2.py --config configs/image.yaml input=data/anya_rgba.png save_path=$save_path $ext_args

if (!(Test-Path -Path "videos")) {
    New-Item -ItemType Directory -Name "videos"
}

python -m kiui.render "logs/$model" --save_video="videos/$save_path.mp4" --wogui
