# Step 2 – Acknowledge assertions and install the snap

Before installing a locally downloaded snap, you must first acknowledge its assertions with `snap ack`. This imports the cryptographic assertions into snapd's local database, allowing the snap to be validated.

## Acknowledge the assertions

```bash
snap ack hello-world_*.assert
```{{exec}}

## Install the snap

```bash
snap install hello-world_*.snap
```{{exec}}

You should see output confirming the snap is installed:

```
hello-world 6.4 from Canonical✓ installed
```

## Verify the installation

```bash
snap list hello-world
```{{exec}}

The snap is now installed and verified against the store's assertions.

> **Further reading:**
> - [Snap assertions – Ubuntu Core](https://documentation.ubuntu.com/core/reference/assertions/)
> - [Installing snap on Ubuntu – Snapcraft](https://snapcraft.io/docs/tutorials/install-the-daemon/ubuntu/)
