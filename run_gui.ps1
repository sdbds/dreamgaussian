$input_file="./data/Snipaste_2023-09-30_01-46-33_rgba.png"
$save_path="./output"
$execution_queue_count=8
$temp_frame_quality=100
$output_video_quality=100
$ui_layouts=""
$max_memory=""

Set-Location $PSScriptRoot
.\venv\Scripts\activate

$Env:HF_HOME = "./huggingface"
$ext_args = [System.Collections.ArrayList]::new()

if ($ui_layouts) {
  [void]$ext_args.Add("--ui-layouts=$ui_layouts")
}

if ($max_memory) {
  [void]$ext_args.Add("--max-memory=$max_memory")
}

python main.py --config configs/image.yaml input=data/anya_rgba.png save_path=anya
python main2.py --config configs/image.yaml input=data/anya_rgba.png save_path=anya
python -m kiui.render logs/anya.obj --save_video videos/anya.mp4 --wogui
#python main.py --config configs/image.yaml input=$input_file save_path=$save_path gui=True
