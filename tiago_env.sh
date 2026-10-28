#!/bin/bash
# Usage:  source <path_to>/tiago_dds_connect/tiago_env.sh
# Sets up ROS 2 env to match TIAGo Pro (domain 2, CycloneDDS, unicast peer 10.68.0.1).

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source /opt/ros/humble/setup.bash

# Find the NIC that has a 10.68.0.x address (robot network). Override with: ROBOT_IFACE=xxx source ...
if [ -z "$ROBOT_IFACE" ]; then
  ROBOT_IFACE=$(ip -o -4 addr show | awk '$4 ~ /^10\.68\.0\./ {print $2; exit}')
fi
if [ -z "$ROBOT_IFACE" ]; then
  echo -e "\033[31m[tiago_env] No interface with 10.68.0.x found. Are you connected to the robot network?\033[0m"
  return 1 2>/dev/null || exit 1
fi
export ROBOT_IFACE

export ROS_DOMAIN_ID=2
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI="file://$HERE/cyclone_tiago.xml"

ros2 daemon stop >/dev/null 2>&1

echo -e "\033[32m[tiago_env] ROS_DOMAIN_ID=$ROS_DOMAIN_ID RMW=$RMW_IMPLEMENTATION IFACE=$ROBOT_IFACE\033[0m"
