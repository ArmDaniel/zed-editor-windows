# zed-editor-windows
Does what the name says, with all the steps required  to make it work properly. It uses Docker


# Instructions

First of all, I will save you some headache, go to Docker Desktop -> Settings -> Resources and disable the resource saver.
Don't worry, you can turn it back on after the build...This is honestly just a prevention, I don't know if it is going to happen to everyone,
but my build failed at some point after a SIGKILL...it needs more from the CPU I suppose. Mine isn't too good so give it a shot if you have a better one.

just cd into the directory where you have downloaded this Dockerfile ,then run:

`docker build -t zed-editor .`

You are going to wait some time...

After it is done, you are gonna need an X server for Windows. I have only tested this with VcxSrv.
When you run VcxSrv, set 'Multiple Windows' , Display: 0, Next, Check all boxes and...
It will try to use Composite by default for redirection, but it fails, so we are gonna disable it...
for additional arguments add:
`-extension Composite`

Save configuration for convenience. Finish.

After , simply run:

`docker run -it --rm --network=host -e DISPLAY=host.docker.internal:0.0 -e XDG_SESSION_TYPE=x11 -e XDG_RUNTIME_DIR=/tmp/xdg -v /tmp/.X11-unix:/tmp/.X11-unix -v <enter_your_project_or_smth_optional> zed-editor`

I am going to have to test making this shorter, not really sure it needs all those arguments, but for now I have managed to summon this creature as such, therefore I will leave this fragile equilibrium untouched.

Ignore the other errors, as it is complaining about various things like missing a copilot config ( eww, who uses copilot ) among others.

Enjoy!

# Just why...

About a couple months ago I kept checking the support for Windows and seeing nothing, I decided I just didn't want to follow the instructions for building from source, but simply make my own Dockerfile to learn something.
Therefore this magical creature.

# Additional information

I honestly started from nothing, trying to add packages according to the errors spewed by cargo.
I gradually made it work, until the errors...were no more.

`libvulkan1` and `mesa-vulkan-drivers` were my primary enemies, because they complained about their existence after a complete build, while trying to actually run the container.
It obviously complained about some missing Vulkan parts.

