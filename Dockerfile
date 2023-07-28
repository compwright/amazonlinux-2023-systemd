FROM amazonlinux:2023

RUN dnf install -y systemd kernel-libbpf

CMD ["/usr/sbin/init"]
