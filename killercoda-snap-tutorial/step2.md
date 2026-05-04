# Step 2: Create an Unconfined Snap

Now we will package our application as a snap. For initial testing, we'll build it in `devmode` (developer mode), which allows the app to run without the security restrictions of strict confinement.

Create a `snapcraft.yaml` file by running the following command:

```bash
cat << 'EOF' > snapcraft.yaml
name: inspire-me
base: core24
version: '1.0'
summary: A C++ app that writes inspirational quotes
description: |
  This application asks for a filename and writes a random 
  inspirational quote to it.

grade: devel
confinement: devmode

parts:
  inspire:
    plugin: nil
    source: .
    override-build: |
      g++ main.cpp -o $SNAPCRAFT_PART_INSTALL/inspire_me
    build-packages:
      - g++

apps:
  inspire-me:
    command: inspire_me
EOF
```{{execute}}

Let's build the snap. This process will set up an environment and compile the application. It may take a minute or two:

```bash
snapcraft
```{{execute}}

After the build completes, install the snap. Since it is unsigned and we built it with `devmode`, we must use `--devmode` and `--dangerous` to install it:

```bash
sudo snap install inspire-me_1.0_amd64.snap --devmode --dangerous
```{{execute}}

Run the application as a snap:

```bash
inspire-me
```{{execute}}

Enter `output.txt` when prompted. Because the snap is in `devmode`, it has full access to your filesystem and will successfully write the file to your current directory.

Verify it was created:

```bash
cat output.txt
```{{execute}}

In the next step, we'll lock down the application using strict confinement.
