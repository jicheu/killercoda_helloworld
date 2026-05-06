# Step 6: Deploy and test the snap on Ubuntu Core

## Objectives

In this step you will:

- Verify that Ubuntu Core has finished booting and `console-conf` is complete
- Copy the strictly confined snap to the Ubuntu Core VM
- Install it, connect the required interfaces, and confirm it runs correctly

## Check Ubuntu Core is ready (Tab 2)

Switch to **Tab 2**. The QEMU console should be showing the `console-conf` confirmation screen or an idle login prompt. If `console-conf` is still in progress, complete it now (see Step 2 for the walkthrough).

Once Ubuntu Core is configured, verify SSH access from **Tab 1**:

```bash
ssh -p 8022 -o StrictHostKeyChecking=no <your-sso-username>@localhost exit && echo "VM ready"
```{{execute}}

Replace `<your-sso-username>` with the username shown at the end of the `console-conf` wizard.

## Copy the snap to the VM

From **Tab 1**, copy the snap over the forwarded SSH port:

```bash
scp -P 8022 -o StrictHostKeyChecking=no inspire-me_1.0_amd64.snap <your-sso-username>@localhost:
```{{execute}}

## Install and connect interfaces on the VM

SSH into the Ubuntu Core VM:

```bash
ssh -p 8022 -o StrictHostKeyChecking=no <your-sso-username>@localhost
```{{execute}}

Install the snap:

```bash
sudo snap install inspire-me_1.0_amd64.snap --dangerous
```{{execute}}

Connect the `home` and `network` interfaces (strict confinement requires these to be granted explicitly, just as you saw in Step 5):

```bash
sudo snap connect inspire-me:home :home
sudo snap connect inspire-me:network :network
```{{execute}}

> **Further reading:** [Supported interfaces – Snapcraft](https://snapcraft.io/docs/supported-interfaces)

## Run the snap on Ubuntu Core

```bash
inspire-me
```{{execute}}

Enter `test.txt` when prompted. Verify the file was written:

```bash
cat test.txt
```{{execute}}

Type `exit` to return to the host.

## Summary

Your strictly confined snap is running on Ubuntu Core — a fully snap-based OS with no traditional package manager. This confirms that the snap's confinement, interface declarations, and runtime behaviour are all correct in the target deployment environment.

> **Next steps:**
> - [Publish your snap to the Snap Store – Snapcraft](https://snapcraft.io/docs/releasing-your-app)
> - [Ubuntu Core documentation – ubuntu.com/core/docs](https://ubuntu.com/core/docs)
> - [Supported interfaces – Snapcraft](https://snapcraft.io/docs/supported-interfaces)
