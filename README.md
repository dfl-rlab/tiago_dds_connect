# tiago_dds_connect

Connect your computer to the **TIAGo Pro** robot and use its ROS 2 topics.

## Requirements

- Ubuntu 22.04 + ROS 2 Humble
- Ethernet cable connected to the robot (your IP must be `10.68.0.x`)
- Docker users: run the container with `--network host`

## 1. Install (once)

```bash
sudo apt update
sudo apt install -y ros-humble-rmw-cyclonedds-cpp iproute2
```

## 2. Source (every new terminal)

```bash
source tiago_dds_connect/tiago_env.sh
```

You should see:

```
[tiago_env] ROS_DOMAIN_ID=2 RMW=rmw_cyclonedds_cpp IFACE=<your_interface>
```

## 3. Check

```bash
ros2 topic list
```

You should see robot topics such as `/scan` and `/cmd_vel`.

## Why is this needed?

The robot uses **CycloneDDS** on **ROS domain 2**, and does not use automatic discovery (multicast). `tiago_env.sh` sets the same DDS and domain, and tells your computer the robot's IP (`10.68.0.1`) directly.

## Troubleshooting

- **`No interface with 10.68.0.x found`**: check the cable and your IP (`ip -br addr`).
- **`ros2 topic list` is empty**: wait a few seconds and try again.
- **Wrong interface selected**: `ROBOT_IFACE=<interface_name> source tiago_dds_connect/tiago_env.sh`
