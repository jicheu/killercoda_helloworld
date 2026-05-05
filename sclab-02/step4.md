# Step 4 – Explore the snap file format

A `.snap` file is a read-only **SquashFS** filesystem image. SquashFS is a compressed, read-only Linux filesystem often used for embedded systems and live media — and it is the foundation of the snap container format.

## Check the file type

Use the `file` command to confirm:

```bash
file hello-world_*.snap
```{{exec}}

The output will look similar to:

```
hello-world_29.snap: Squashfs filesystem, little endian, version 4.0, 19330 bytes, 10 inodes, blocksize: 131072 bytes, created: Wed Apr 17 15:16:46 2019
```

This confirms the snap is a standard SquashFS image. Snapd mounts it as a loopback device when the snap is installed, which is why snaps are read-only at runtime.

## Why SquashFS?

- **Compression** – snaps are smaller on disk and download faster.
- **Read-only integrity** – the filesystem cannot be modified at runtime, which supports the snap security model.
- **Atomic updates** – a new revision is a new SquashFS image, so rollback is trivial.

> **Further reading:** [Snap documentation overview – Snapcraft](https://snapcraft.io/docs/)
