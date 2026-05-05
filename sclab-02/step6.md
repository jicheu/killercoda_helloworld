# Step 6 – Repack and install in dangerous mode

## Objectives

In this step you will:

- Repack the extracted `squashfs-root/` directory into a new `.snap` file using `snap pack`
- Understand what an *unasserted* snap is and why it needs `--dangerous`
- Install the repacked snap and verify it runs

## Required tools

`snap pack` is part of `snapd` and is already available. No additional installation is needed.

## Repack the snap

The `snap pack` command takes a directory as its argument and creates a new `.snap` file in the current directory:

```bash
snap pack squashfs-root/
```{{exec}}

List all snap files to see the result:

```bash
ls -lh *.snap
```{{exec}}

You will see the original downloaded snap alongside a newly created file (e.g. `hello-world_6.4_all.snap`).

The new snap is **unasserted**: it has never been uploaded to the Snap Store, so there is no store-signed `snap-revision` assertion linking it to a publisher or a trusted build.

## Install in dangerous mode

Because the repacked snap has no valid assertions, a standard `snap install` will fail. Use the `--dangerous` flag to bypass assertion and signature verification:

```bash
snap install hello-world_6.4_all.snap --dangerous
```{{exec}}

> **Tip:** If the filename differs, use `ls *.snap` to find the exact name, or use tab-completion.

According to the [Snap install modes documentation](https://snapcraft.io/docs/install-modes):

> The `--dangerous` argument will install a local snap without validating or checking its assertions or signatures. This option is useful when testing snaps shared through a trusted channel, and for testing snaps built locally, before eventually being published to the store.

## Verify the installation

```bash
snap list hello-world
```{{exec}}

The snap is listed with no special `Notes` — it is still strictly confined. The `--dangerous` flag only bypasses the provenance check; confinement is unaffected.

Run the snap to confirm it works:

```bash
hello-world
```{{exec}}

> **Further reading:**
> - [Snap install modes – Snapcraft](https://snapcraft.io/docs/install-modes)
> - [Craft a snap tutorial – Snapcraft](https://documentation.ubuntu.com/snapcraft/stable/tutorials/craft-a-snap/)

## Summary

You used `snap pack` to repack the extracted directory into a new snap file and installed it with `--dangerous` to bypass assertion checks. This round-trip workflow — extract, modify, repack, install — is a standard technique for debugging snaps without a full store publish cycle. The snap remains strictly confined regardless of the `--dangerous` flag.
