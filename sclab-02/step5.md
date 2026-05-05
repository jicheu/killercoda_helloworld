# Step 5 – Unsquash and explore the snap contents

Now that we know a snap is a SquashFS image, we can extract (unsquash) it to examine its internal directory layout.

## Unsquash the snap

```bash
unsquashfs hello-world_*.snap
```{{exec}}

This extracts the snap into a directory called `squashfs-root/` in your current working directory.

## Explore the directory structure

```bash
find squashfs-root/ -maxdepth 3
```{{exec}}

Key paths to note:

### `squashfs-root/meta/snap.yaml`

This is the **snap manifest** — the core metadata file that snapd reads when the snap is installed.

```bash
cat squashfs-root/meta/snap.yaml
```{{exec}}

It declares the snap name, version, summary, and the applications (commands) the snap exposes.

### `squashfs-root/bin/`

```bash
ls -lh squashfs-root/bin/
```{{exec}}

This directory contains the executable(s) shipped with the snap. The `bin/` directory is a common convention, but it is **not mandatory** — snaps may place binaries anywhere inside the SquashFS image and reference them via `snap.yaml`.

### What about `snap/manifest.yaml`?

This file is **not present** in the hello-world snap. When included by a snap build, it allows Ubuntu archive management tools to notify snap publishers about Ubuntu Security Notices affecting packages bundled inside the snap, so they can rebuild and release a fix.

> **Note:** The `meta/` directory is always present. The `bin/` directory is a common convention, not a requirement. The `snap/manifest.yaml` is optional and only present when the snap was built to include it.

> **Further reading:** [Debug snaps with snap try – Snapcraft](https://snapcraft.io/docs/snap-try)
