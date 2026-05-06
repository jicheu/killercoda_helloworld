# Step 6: Deploy and test the snap on Ubuntu Core

## Objectives

In this step you will:

- Copy the strictly confined snap to the Ubuntu Core VM
- Install it and connect the required interfaces
- Verify the snap runs correctly on a fully snap-based OS

## Install Tools

`scp` and `ssh` are pre-installed on Ubuntu. No additional packages are needed.

## Copy the snap to the VM

From the **host terminal** (not the QEMU console), copy the snap to the VM over the forwarded SSH port:

```bash
scp -P 8022 -o StrictHostKeyChecking=no inspire-me_1.0_amd64.snap <your-sso-username>@localhost:
```

Replace `<your-sso-username>` with your Ubuntu SSO username (shown at the end of the `console-conf` wizard in Step 5).

## Install and connect interfaces on the VM

SSH into the Ubuntu Core VM:

```bash
ssh -p 8022 -o StrictHostKeyChecking=no <your-sso-username>@localhost
```

Install the snap:

```bash
sudo snap install inspire-me_1.0_amd64.snap --dangerous
```

Connect the `home` and `network` interfaces (strict confinement requires these to be granted explicitly — as you saw in Step 3):

```bash
sudo snap connect inspire-me:home :home
sudo snap connect inspire-me:network :network
```

> **Further reading:** [Supported interfaces – Snapcraft](https://snapcraft.io/docs/supported-interfaces)

## Run the snap

```bash
inspire-me
```

When prompted, enter `test.txt`. Verify the file was written:

```bash
cat test.txt
```

Type `exit` to return to the host when done.

## Summary

Your strictly confined snap is running on Ubuntu Core — a fully snap-based OS with no traditional package manager. This confirms that the snap's confinement, interface declarations, and runtime behaviour are all correct in the target deployment environment.

> **Next steps:**
> - [Publish your snap to the Snap Store – Snapcraft](https://snapcraft.io/docs/releasing-your-app)
> - [Ubuntu Core documentation – ubuntu.com/core/docs](https://ubuntu.com/core/docs)
> - [Supported interfaces – Snapcraft](https://snapcraft.io/docs/supported-interfaces)
