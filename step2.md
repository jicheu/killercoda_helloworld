## Step 2: Create a Hello World App
Let's create a directory for our project:
`mkdir my-snap && cd my-snap`{{execute}}

Create a simple Bash script that will be our "app":
```bash
cat <<EOF > hello.sh
#!/bin/bash
echo "Hello from a confined Snap!"
EOF
chmod +x hello.sh
```{{execute}}

Now, initialize the Snapcraft config:
`snapcraft init`{{execute}}
