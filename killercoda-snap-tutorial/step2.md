# Step 2: Start Ubuntu Core in the background

## Objectives

In this step you will:

- Launch the Ubuntu Core 24 VM in a **second terminal tab** so it boots while you work
- Complete the [`console-conf`](https://ubuntu.com/core/docs/use-console-conf) first-boot wizard in that tab when it appears
- Switch back to Tab 1 to continue with the tutorial — the VM will be ready by Step 6

> **Two-tab workflow**
> QEMU can take several minutes to boot Ubuntu Core. Rather than blocking the tutorial, you will start the VM now in a second tab and let it run in the background. Continue building your snap in Tab 1 (Steps 3–5). Check Tab 2 periodically — when `console-conf` appears, complete the wizard, then switch straight back to Tab 1.

## Install Tools

QEMU and the Ubuntu Core 24 image were installed and downloaded in the background at the start of this tutorial. Verify they are ready:

```bash
ls -lh /root/ubuntu-core-24-amd64.img
```{{execute}}

*(If the file is missing or still ends in `.xz`, wait a few moments for the background script to finish, then retry.)*

## Open a second terminal tab

In Killercoda, click the **+** button at the top of the terminal panel to open a second tab. **All remaining commands in this step run in Tab 2.**

## Start the VM (in Tab 2)

Ensure the writable OVMF variable store is in place:

```bash
ls /root/OVMF_VARS_4M.fd 2>/dev/null || cp /usr/share/OVMF/OVMF_VARS_4M.fd /root/OVMF_VARS_4M.fd
```{{execute}}

Launch the Ubuntu Core VM. The `-nographic` flag redirects the VM's serial console to your terminal so you can interact with `console-conf` when it appears:

```bash
qemu-system-x86_64 -smp 2 -m 2048 -accel kvm -accel tcg \
  -drive file=/usr/share/OVMF/OVMF_CODE_4M.fd,if=pflash,format=raw,unit=0,readonly=on \
  -drive file=/root/OVMF_VARS_4M.fd,if=pflash,format=raw,unit=1 \
  -drive file=/root/ubuntu-core-24-amd64.img,format=raw \
  -net nic,model=virtio -net user,hostfwd=tcp::8022-:22 \
  -nographic
```{{execute}}

Once the QEMU command is running, **switch back to Tab 1 immediately** and continue with Step 3. You do not need to wait for the VM to boot.

## Complete the console-conf wizard (in Tab 2, when it appears)

Ubuntu Core takes 2–3 minutes to boot. When the `console-conf` wizard appears in Tab 2, switch over and complete it:

---

**Screen 1 — Network**

Ubuntu Core tries to configure networking via DHCP. In QEMU's user-mode networking the network is always available. Press **Enter** to accept and continue.

---

**Screen 2 — Ubuntu SSO email**

```
Please enter your email address to configure your device.
Email address:
```

Type the **email address linked to your Ubuntu One account** (registered in Step 1) and press **Enter**.

`console-conf` connects to `login.ubuntu.com`, looks up your Launchpad profile, and injects your SSH public key into the system. Your Ubuntu SSO **username** (not email) becomes the login name on the device.

---

**Screen 3 — Confirmation**

```
This device is configured. You can now connect to it via SSH:

    ssh <your-sso-username>@<ip-address>
```

Note your SSO username — you will need it in Step 6. Once you see this screen, **switch back to Tab 1** and keep going.

> **Further reading:** [`console-conf` documentation – ubuntu.com/core/docs](https://ubuntu.com/core/docs/use-console-conf)

## Summary

The Ubuntu Core VM is booting in Tab 2. Switch back to **Tab 1** now and continue with Step 3. The VM will be ready and waiting by the time you reach Step 6.
