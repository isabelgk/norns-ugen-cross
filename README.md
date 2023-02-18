# norns-ugen-cross

An example of writing a SuperCollider UGen in C++, cross compiling for RPi using Docker, and
wrapping it for distribution for monome norns.


## Requirements

- [Docker >= 19.03.13](https://docs.docker.com/engine)
- [buildx >= 0.4.1](https://github.com/docker/buildx#installing)


## Building and installing

First, you write your UGen C++ code as you normally would. This is the code you see in `/src`. Some
necessary headers are included in `/include`, though normally this should be kept in sync with a
local copy of the supercollider source code. You only really need these headers, so they're here for
convenience from my first hacking attempts.

To compile these UGens for RPi 3/3+, we need to set up some Docker images which "hold" our
compilation toolchain. These are the `Dockerfile.cross` and `Dockerfile.cross-pi` Dockerfiles. The
first is a base image that contains the compilers and related tools we'll need, and the second
extends the base (although it might actually be unnecessary -- TODO to try removing). The last
Dockerfile, just called `Dockerfile` is the one that, when built as an image, also copies in our
source code and compiles the UGen, copying it out into a `/bin` directory when it's finished.

_The steps to build these Docker images are shown in `build.sh`._ You can run the script directly if
you have bash available, or just run them yourself.

To install the UGens, first, ssh into your norns and make sure you have created a directory
called `~/.local/share/SuperCollider/Extensions/MySaw`. You can then quit the session and return to
the host terminal where we'll copy the remaining files over.

First, copy `MySaw.so` and `MySaw.sc` to install the UGens.
```
scp bin/MySaw.so we@norns.local:~/.local/share/SuperCollider/Extensions/MySaw
scp src/MySaw.sc we@norns.local:~/.local/share/SuperCollider/Extensions/MySaw
```

Restart your norns.

Now, install the norns script by copying the `mysaw` directory into `~/dust/code`, and don't miss
the `-r` flag.

```
scp -r mysaw we@norns.local:~/dust/code
```


## Further reading

- [Cross Compiling for Raspberry Pi with
  Docker](https://rolandsdev.blog/posts/cross-compile-for-raspberry-pi-with-docker/)
- [Norns Engine Study](https://monome.org/docs/norns/engine-study-1/)
- [SuperCollider Plugin
  Tutorial](https://raw.githubusercontent.com/notam02/supercollider-plugin-tutorial/main/tutorial/how-to-make-a-supercollider-plugin-cpp.pdf)
- [SuperCollider Example Plugins](https://github.com/supercollider/example-plugins)
