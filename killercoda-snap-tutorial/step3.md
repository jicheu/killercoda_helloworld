# Step 3: Strict Confinement & LXD Deployment

Let's switch our application to strict confinement. In strict mode, the app runs in complete isolation and cannot access the host filesystem (like your home directory) unless explicitly granted permission.

Update the `snapcraft.yaml` to enforce strict confinement, but *without* any plugs:

```bash
cat << 'EOF' > snapcraft.yaml
name: inspire-me
base: core24
version: '1.0'
summary: A C++ app that writes inspirational quotes
description: |
  This application asks for a filename and writes a random 
  inspirational quote to it.

grade: stable
confinement: strict

parts:
  inspire:
    plugin: nil
    source: .
    override-build: |
      g++ main.cpp -o $SNAPCRAFT_PART_INSTALL/inspire_me
    build-packages:
      - g++

apps:
  inspire-me:
    command: inspire_me
EOF
```{{execute}}

Clean the previous build and rebuild the snap:

```bash
snapcraft clean
snapcraft pack
```{{execute}}

Install the updated, strictly confined snap:

```bash
sudo snap install inspire-me_1.0_amd64.snap --dangerous
```{{execute}}

Run the strictly confined snap and try to write to `strict.txt`:

```bash
inspire-me
```{{execute}}

You should see an error similar to: **"Error: Could not open file strict.txt for writing."**
This happens because the strictly confined snap does not have permission to access your home directory by default!

## Connecting the Home Interface

To fix this, we need to explicitly connect the interface that grants access to the home directory. The `snapcraft.yaml` doesn't have the `home` plug specified yet. Let's add it.

```bash
cat << 'EOF' > snapcraft.yaml
name: inspire-me
base: core24
version: '1.0'
summary: A C++ app that writes inspirational quotes
description: |
  This application asks for a filename and writes a random 
  inspirational quote to it.

grade: stable
confinement: strict

parts:
  inspire:
    plugin: nil
    source: .
    override-build: |
      g++ main.cpp -o $SNAPCRAFT_PART_INSTALL/inspire_me
    build-packages:
      - g++

apps:
  inspire-me:
    command: inspire_me
    plugs:
      - home
EOF
```{{execute}}

Rebuild and install the snap one final time:

```bash
snapcraft pack
sudo snap install inspire-me_1.0_amd64.snap --dangerous
```{{execute}}

Now, explicitly connect the `home` interface to grant permission (some snaps auto-connect this, but it's good practice to ensure it's connected during local testing):

```bash
sudo snap connect inspire-me:home :home
```{{execute}}

Run it again and save the file in your home directory:

```bash
inspire-me
```{{execute}}

When prompted, enter `strict-working.txt`. It should now successfully write the file!

## Running on an Emulated Core Image via LXD

Finally, let's verify that our snap runs smoothly on a minimalistic Ubuntu Core environment. We'll use LXD to launch a virtual machine running Ubuntu Core.

First, initialize LXD if it isn't already, and launch an Ubuntu Core 24 VM. This might take a minute or two to start up fully:

```bash
lxd init --auto
lxc launch ubuntu-core:24 core-vm --vm
```{{execute}}

Wait for the VM to fully boot and its internal snapd service to become ready. We can monitor it:

```bash
sleep 15
lxc exec core-vm -- snap wait system seed.loaded
```{{execute}}

Now, push our compiled `.snap` file to the Core VM and install it:

```bash
lxc file push inspire-me_1.0_amd64.snap core-vm/root/
lxc exec core-vm -- snap install /root/inspire-me_1.0_amd64.snap --dangerous
```{{execute}}

Execute the application inside the Core VM!

```bash
lxc exec core-vm -- inspire-me
```{{execute}}

When prompted, you can enter `/var/snap/inspire-me/current/core-message.txt`. Because we run it as root, and we write to the snap's specific app data directory, we know for a fact it has permissions even on Ubuntu Core!

Verify the file was created inside the VM:

```bash
lxc exec core-vm -- cat /var/snap/inspire-me/current/core-message.txt
```{{execute}}

Congratulations! You've successfully built, strictly confined, and tested your snap natively and on an Ubuntu Core environment!
