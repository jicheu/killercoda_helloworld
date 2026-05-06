# Step 3: Strict Confinement

## Objectives
We will switch our application to [Strict Confinement](https://snapcraft.io/docs/snap-confinement). In strict mode, the app runs in complete isolation and cannot access the host filesystem (like your home directory) unless explicitly granted permission via [Interfaces](https://snapcraft.io/docs/supported-interfaces).

## Install Tools
No new tools are required for this step. We will use standard Linux utilities like `sed`.

## Achieve Objectives
Let's modify our existing `snapcraft.yaml` to enforce strict confinement. We will use `sed` to update the `grade` and `confinement` fields:

```bash
sed -i 's/grade: devel/grade: stable/' snapcraft.yaml
sed -i 's/confinement: devmode/confinement: strict/' snapcraft.yaml
```{{execute}}

Clean the previous build and rebuild the snap:

```bash
snapcraft clean
snapcraft pack --destructive-mode
```{{execute}}

> **Reminder:** `--destructive-mode` is used here for speed in this tutorial environment. In production always run `snapcraft` without this flag so the build happens inside an isolated LXD or Multipass container. See [Build options – Snapcraft](https://snapcraft.io/docs/build-options).

Install the updated, strictly confined snap (note we no longer use `--devmode`):

```bash
sudo snap install inspire-me_1.0_amd64.snap --dangerous
```{{execute}}

Run the strictly confined snap and try to write to `strict.txt`:

```bash
inspire-me
```{{execute}}

You should see an error similar to: **"Error: Could not open file strict.txt for writing."**
This happens because the strictly confined snap does not have permission to access your home directory by default!

### Connecting the Home Interface

To fix this, we need to explicitly connect the interface that grants access to the home directory. Let's append the `home` plug to our `snapcraft.yaml`:

```bash
sed -i '/command: inspire_me/a \    plugs:\n      - home\n      - network' snapcraft.yaml
```{{execute}}
*(Note: We also added `network` because strict snaps need explicit permission to make network requests, which `curl` requires!)*

Rebuild and install the snap one final time:

```bash
snapcraft pack --destructive-mode  # tutorial shortcut — use plain `snapcraft` in production
sudo snap install inspire-me_1.0_amd64.snap --dangerous
```{{execute}}

Explicitly connect the interfaces to grant permission:

```bash
sudo snap connect inspire-me:home :home
sudo snap connect inspire-me:network :network
```{{execute}}

Run it again and save the file in your home directory:

```bash
inspire-me
```{{execute}}

When prompted, enter `strict-working.txt`. It should now successfully write the file!

## Conclusion
We learned how strict confinement restricts an application's access and how to selectively grant permissions using snap interfaces like `home` and `network`. Next, we will run our snap on an emulated Ubuntu Core system.
