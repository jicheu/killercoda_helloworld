# Step 5: Boot Ubuntu Core and configure with console-conf

## Objectives

In this step you will:

- Launch the Ubuntu Core 24 VM using QEMU
- Complete the [`console-conf`](https://ubuntu.com/core/docs/use-console-conf) first-boot wizard using your Ubuntu SSO credentials
- Verify that SSH access to the VM is working before deploying the snap

## Install Tools

QEMU and the Ubuntu Core 24 image were installed and downloaded in the background at the start of this tutorial. Verify the image is ready:

```bash
ls -lh /root/ubuntu-core-24-amd64.img
```{{execute}}

*(If the file is missing or still ends in `.xz`, wait a few moments for the background script to finish, then retry.)*

## Boot the VM

Ensure the writable OVMF variable store is in place (the background script copies it, but this is a safety check):

```bash
ls /root/OVMF_VARS_4M.fd 2>/dev/null || cp /usr/share/OVMF/OVMF_VARS_4M.fd /root/OVMF_VARS_4M.fd
```{{execute}}

Launch the Ubuntu Core VM. The `-nographic` flag redirects the VM's serial console to your terminal so you can interact with `console-conf`:

```bash
qemu-system-x86_64 -smp 2 -m 2048 -accel kvm -accel tcg \
  -drive file=/usr/share/OVMF/OVMF_CODE_4M.fd,if=pflash,format=raw,unit=0,readonly=on \
  -drive file=/root/OVMF_VARS_4M.fd,if=pflash,format=raw,unit=1 \
  -drive file=/root/ubuntu-core-24-amd64.img,format=raw \
  -net nic,model=virtio -net user,hostfwd=tcp::8022-:22 \
  -nographic
```{{execute}}

Ubuntu Core takes about a minute to complete its first-boot initialisation. Wait until the `console-conf` wizard appears on screen.

## Complete the console-conf wizard

`console-conf` guides you through two screens:

---

**Screen 1 — Network**

Ubuntu Core tries to configure networking via DHCP. In QEMU's user-mode networking the network is always available. Press **Enter** to accept and continue.

---

**Screen 2 — Ubuntu SSO email**

```
Please enter your email address to configure your device.
Email address:
```

Type the **email address linked to your Ubuntu One account** (the one you registered in Step 4) and press **Enter**.

`console-conf` connects to `login.ubuntu.com`, looks up your Launchpad profile, and injects your SSH public key into the system. Your Ubuntu SSO **username** (not email) becomes the login name on the device.

---

**Screen 3 — Confirmation**

Once the key is imported you will see a message similar to:

```
This device is configured. You can now connect to it via SSH:

    ssh <your-sso-username>@<ip-address>
```

Note your SSO username shown here — you will use it in the next step.

> **Further reading:** [`console-conf` documentation – ubuntu.com/core/docs](https://ubuntu.com/core/docs/use-console-conf)

## Verify SSH access

Open a **second terminal tab** in Killercoda (the first is occupied by the QEMU session). Test the SSH connection using port `8022`, which QEMU forwards to the VM's port 22:

```bash
ssh -p 8022 -o StrictHostKeyChecking=no <your-sso-username>@localhost
```

Replace `<your-sso-username>` with the username shown on the `console-conf` confirmation screen. If the connection succeeds you are inside the Ubuntu Core VM. Type `exit` to return to the host for now.

> **Further reading:** [Testing Ubuntu Core with QEMU – ubuntu.com/core/docs](https://ubuntu.com/core/docs/testing-with-qemu)

## Summary

Ubuntu Core is running in QEMU and accessible over SSH. In the next step you will copy your snap to the VM, install it, and confirm it runs correctly under strict confinement on a fully snap-based OS.
