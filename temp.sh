#!/bin/bash

# 実行日付取得
date=(`date +"%Y/%m/%d"`)
# 実行時間取得
time=(`date +"%H:%M:%S"`)

# ロードアベレージ
#load=$(uptime | awk '{print $(NF-2),$(NF-1),$NF}')
# ロードアベレージ（カンマ除去／3値のみ抽出）
read load1 load5 load15 <<< $(uptime | awk -F'load average: ' '{print $2}' | tr -d ',')

# CPU温度取得
temp=(`cat /sys/class/thermal/thermal_zone0/temp`)
# CPUの現在のクロック数取得
freq=(`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`)
# ファン回転数
#fan=$(sensors | grep 'fan1' | awk '{print $2}')
fan=$(sensors | awk '/fan1:/ {print $2; exit}')

# 結果文字列生成
str="$date,$time,$freq,$temp,$fan,$load1,$load5,$load15"

# ログファイル出力
echo $str
