# Step 6 – Repack and install in dangerous mode

You can repack the `squashfs-root/` directory back into a `.snap` file. This is a useful debugging technique: modify the contents of the extracted directory, repack, and reinstall to test changes without going through a full build cycle.

## Repack the snap

```bash
snap pack squashfs-root/
```{{exec}}

The `snap pack` command takes a directory as its argument and creates a new `.snap` file in the current directory. The resulting snap is **unasserted** — it has never been uploaded to the Snap Store and therefore has no store-signed assertions linking it to a publisher.

List the newly created snap:

```bash
ls -lh *.snap
```{{exec}}

You will see a new snap file (e.g. `hello-world_6.4_all.snap`) alongside the original downloaded one.

## Install in dangerous mode

Because the repacked snap has no valid assertions, snapd will refuse a normal install. You must use the `--dangerous` flag:

```bash
snap install hello-world_6.4_all.snap --dangerous
```{{exec}}

> **Tip:** If the filename differs, use tab-completion or `ls *.snap` to find the exact name.

The `--dangerous` flag tells snapd to skip assertion and signature verification. According to the [Snap install modes documentation](https://snapcraft.io/docs/install-modes):

> The `--dangerous` argument will install a local snap without validating or checking its assertions or signatures. This option is useful when testing snaps shared through a trusted channel, and for testing snaps built locally, before eventually being published to the store.

Verify the snap is installed:

```bash
snap list hello-world
```{{exec}}

The `Notes` column will not show any special mode — the snap is strictly confined as normal, but its provenance is unverified.

> **Further reading:**
> - [Snap install modes – Snapcraft](https://snapcraft.io/docs/install-modes)
> - [Craft a snap tutorial – Snapcraft](https://documentation.ubuntu.com/snapcraft/stable/tutorials/craft-a-snap/)
