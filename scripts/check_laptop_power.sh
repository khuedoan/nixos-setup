#!/bin/sh

echo "===== CPU ====="
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver | uniq
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor | uniq
cat /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference | uniq

echo "===== GPU ====="
cat /sys/class/drm/card0/device/power_dpm_force_performance_level
