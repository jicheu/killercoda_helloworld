# Step 4: Emulated Core Image Deployment

## Objectives
We will verify that our snap runs smoothly on a minimalistic [Ubuntu Core](https://ubuntu.com/core/docs) environment. Ubuntu Core is an entirely snap-based operating system designed for IoT and embedded environments. We'll use [QEMU](https://ubuntu.com/core/docs/testing-with-qemu) to emulate the Core image, providing a robust testing environment regardless of hypervisor constraints.

## Install Tools
QEMU and the Ubuntu Core 24 image have been installed and downloaded in the background for you to save time! 

In real life, you would have to install `qemu` with apt, and download the image from [Ubuntu Archive](https://cdimage.ubuntu.com/ubuntu-core/24/stable/current/)

You can verify the image is ready:

```bash
ls -lh /root/ubuntu-core-24-amd64.img
```{{execute}}

*(Note: If the file is still an `.xz` or missing, wait a few moments for the background download to finish).*

## Achieve Objectives
We will launch the Ubuntu Core virtual machine using QEMU. Ubuntu Core requires a UEFI boot environment, so we include OVMF (Open Virtual Machine Firmware) as a `pflash` drive. We also use host forwarding (`hostfwd`) so we can SSH into the VM later. For official guidance, refer to [Testing Ubuntu Core with QEMU](https://ubuntu.com/core/docs/testing-with-qemu).

First, copy the OVMF variable store to a writable location (QEMU needs to write EFI variables to it at runtime):

```bash
cp /usr/share/OVMF/OVMF_VARS_4M.fd /root/OVMF_VARS_4M.fd
```{{execute}}

```bash
qemu-system-x86_64 -smp 2 -m 2048 -accel kvm -accel tcg \
  -drive file=/usr/share/OVMF/OVMF_CODE_4M.fd,if=pflash,format=raw,unit=0,readonly=on \
  -drive file=/root/OVMF_VARS_4M.fd,if=pflash,format=raw,unit=1 \
  -drive file=/root/ubuntu-core-24-amd64.img,format=raw \
  -net nic,model=virtio -net user,hostfwd=tcp::8022-:22 \
  -nographic
```{{execute}}

When Ubuntu Core boots for the first time, it will present `console-conf`. Follow the on-screen prompts to configure the network and enter your Ubuntu SSO (Launchpad) email address. This will automatically inject your SSH keys into the VM.

Once configured, you can open a second terminal tab and push your snap to the VM:

```bash
scp -P 8022 inspire-me_1.0_amd64.snap <your-sso-username>@localhost:
```

Then SSH into the Core VM to install and test it:

```bash
ssh -p 8022 <your-sso-username>@localhost
sudo snap install inspire-me_1.0_amd64.snap --dangerous
sudo snap connect inspire-me:network :network
echo "test.txt" | inspire-me
```

## Conclusion
Congratulations! You've successfully built, strictly confined, and deployed your snap onto an emulated Ubuntu Core system using QEMU!
