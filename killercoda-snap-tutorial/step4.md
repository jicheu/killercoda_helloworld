# Step 4: Emulated Core Image Deployment

## Objectives
We will verify that our snap runs smoothly on a minimalistic [Ubuntu Core](https://ubuntu.com/core/docs) environment. Ubuntu Core is an entirely snap-based operating system designed for IoT and embedded environments. We'll use LXD to launch a virtual machine running Ubuntu Core.

## Install Tools
Ensure `lxd` is installed (it usually comes pre-installed on modern Ubuntu server images).

## Achieve Objectives
Initialize LXD and launch an Ubuntu Core 24 VM. We use the `ubuntu:` remote with the `core24` image:

```bash
lxd init --auto
lxc launch ubuntu:core24 core-vm --vm
```{{execute}}

Wait for the VM to fully boot and its internal snapd service to become ready:

```bash
sleep 15
lxc exec core-vm -- snap wait system seed.loaded
```{{execute}}

Push our compiled `.snap` file to the Core VM and install it. Note that we push it to `/var/tmp/` because the root filesystem on Ubuntu Core is strictly read-only:

```bash
lxc file push inspire-me_1.0_amd64.snap core-vm/var/tmp/
lxc exec core-vm -- snap install /var/tmp/inspire-me_1.0_amd64.snap --dangerous
```{{execute}}

Connect the `network` interface inside the VM so our application can fetch quotes! (Note: The `home` interface isn't typically connected on Ubuntu Core in the same way because there are no traditional user homes, but we will write to the snap's specific writable directory instead).

```bash
lxc exec core-vm -- snap connect inspire-me:network :network
```{{execute}}

Execute the application inside the Core VM. We will pass the target file path via `stdin` since `lxc exec` might not cleanly handle the interactive prompt:

```bash
echo "/var/snap/inspire-me/current/core-message.txt" | lxc exec core-vm -- inspire-me
```{{execute}}

Verify the file was created inside the VM and check the inspirational message:

```bash
lxc exec core-vm -- cat /var/snap/inspire-me/current/core-message.txt
```{{execute}}

## Conclusion
Congratulations! You've successfully built, strictly confined, and tested your snap natively and on an Ubuntu Core environment!
