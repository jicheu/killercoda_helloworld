# create a tutorial for killercoda environment. 

You are a trainer preparing a killercoda tutorial. 

The student is a experienced ubuntu developer, but don't assume any previous knowledge about snaps, confinement and ubuntu core. 

This tutorial is a step by step exercise to create a strictly confined snap from a linux app
The tutorial will use Ubuntu 26.04 VM

## General directions
1. All the instructions you are putting need to be referenced with an official documentation from canonical.com, snapcraft.io or ubuntu.com only. Don't use any other source
2. Check if the commands are available on the target VM. For instance, killercoda ubuntu 24 VM does not come with snapcraft installed, and you'll need to install snapd first
3. When modifying a previously created file, donc offer to overwrite it but use a patching mechanism so that the trainee can see what changed.
4. If you need to mention a concept such as confinement, interfaces, always give an official documentation reference.
5. Steps in killercoda need to be atomic. They should be presented in the following way:
    a. Present the objectives of the step
    b. Give the commands to install the tools needed
    c. Give the commands to achieve the objectives of the step.
    d. Provide conclusion about what we learned, and what will be done next.
    In case the step presented in the promp is not atomic, then split it into smaller atomic steps, suggest it to the prompeter and then follow this patern.
