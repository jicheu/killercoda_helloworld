# Step 1 – Download the hello-world snap

The `snap download` command fetches a snap and its accompanying assertions from the Snap Store without installing it. This is useful when you want to inspect or sideload a snap.

Run the following command:

```bash
snap download hello-world
```{{exec}}

You should see output similar to:

```
Fetching snap "hello-world"
Fetching assertions for "hello-world"
Install the snap with:
    snap ack hello-world_29.assert
    snap install hello-world_29.snap
```

Two files are downloaded to your current directory:

- **`hello-world_<rev>.snap`** – the snap package itself (a SquashFS image)
- **`hello-world_<rev>.assert`** – a bundle of signed assertions from the Snap Store

> **Note:** The revision number in the filenames (e.g. `_29`) may differ because the snap may have been updated since this lab was written. The commands in subsequent steps use a shell glob (`hello-world_*.snap`) to handle this automatically.

Verify the files are present:

```bash
ls -lh hello-world_*
```{{exec}}

You should see both the `.snap` and `.assert` files listed.

> **Further reading:** [Snap documentation – Getting started](https://snapcraft.io/docs/tutorials/get-started/)
