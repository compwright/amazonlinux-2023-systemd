# Running Amazon Linux 2023 with systemd in Docker

Running systemd inside docker has historically been very difficult to nearly impossible. However, this has become substantially easier in recent years due to advances in Docker, the Linux kernel, systemd, and distros that use them—such as Amazon Linux 2023 (loosely based on Fedora).

All that said, Amazon unfortunately provides no guidance and it doesn't work out of the box. After two days of sifting through mostly unhelpful search results and trying this and that, I've discovered the right combination of settings to boot systemd inside Docker.

## Requirements

Assuming you are running the latest version of Docker, getting systemd to play nice comes down to two things:

1. Having the right dependencies installed. For [amazonlinux:2023](https://hub.docker.com/_/amazonlinux/), you need these packages:

    - `systemd`
    - `kernel-libbpf`

    These have to be pre-installed, and you must use a Dockerfile to do that. It doesn't seem to work if you install these at the command line after the image has already been booted, and then try to start systemd.

2. Having the right run-time permissions and settings in place.
    
    You need these options:
    
    - `--cgroupns=host`
    - `--cap_add=SYS_ADMIN`
    - `--cap_add=NET_ADMIN`
    - `--tty`
    - `-v /sys/fs/cgroup:/sys/fs/cgroup:rw` volume.
    
    You do NOT need these options:
    
    - `--privileged`

## Give it a try

Check out this repo, and run the following to try it out:

    $ docker-compose up
