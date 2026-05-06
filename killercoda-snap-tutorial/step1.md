# Step 1: Prepare your Ubuntu SSO credentials

## Objectives

In this step you will:

- Understand why Ubuntu Core requires an Ubuntu SSO account for first-boot configuration
- Create an Ubuntu One account (if you don't have one already)
- Generate an SSH key pair on this machine and upload the public key to your Launchpad profile

> **Why is this needed?**
> Ubuntu Core uses [`console-conf`](https://ubuntu.com/core/docs/use-console-conf) for first-boot device provisioning. During this process it contacts your Ubuntu SSO / Launchpad profile and fetches your SSH public key, which it injects into the system. Without this, you will not be able to SSH into the VM after boot.
>
> **Further reading:** [console-conf documentation – ubuntu.com/core/docs](https://ubuntu.com/core/docs/use-console-conf)

## Install Tools

No additional packages are needed. `ssh-keygen` and `cat` are pre-installed on Ubuntu.

## Set up your Ubuntu One account and SSH key

### 1. Create an Ubuntu One account

If you do not already have one, create a free account at [login.ubuntu.com](https://login.ubuntu.com). Take note of your **username** — it becomes the login name on the Ubuntu Core device.

### 2. Generate an SSH key pair

Check whether an SSH key pair already exists on this machine:

```bash
ls ~/.ssh/id_*.pub 2>/dev/null && echo "Key found" || echo "No key found — generating one"
```{{execute}}

If no key was found, generate one now:

```bash
ssh-keygen -t ed25519 -C "ubuntu-core-lab" -N "" -f ~/.ssh/id_ed25519
```{{execute}}

Display your public key:

```bash
cat ~/.ssh/id_ed25519.pub
```{{execute}}

Copy the entire output line — you will paste it into Launchpad in the next sub-step.

### 3. Upload your public key to Launchpad

1. Go to [launchpad.net](https://launchpad.net) and sign in with your Ubuntu One credentials.
2. Navigate to **Your profile → SSH keys**, or open `https://launchpad.net/~YOUR_USERNAME/+editsshkeys` directly.
3. Paste the public key you copied above and click **Import**.

`console-conf` will contact Launchpad during first boot and inject this key automatically.

> **Further reading:** [Testing Ubuntu Core with QEMU – ubuntu.com/core/docs](https://ubuntu.com/core/docs/testing-with-qemu)

## Summary

Your Ubuntu One account is ready and your SSH public key is registered on Launchpad. In the next step you will start the Ubuntu Core VM in a second terminal tab so it boots in the background while you work through the rest of the tutorial.
