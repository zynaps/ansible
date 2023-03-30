## Usage

#### Add host common playbook and wireguard variables

```console
$ task host:add -- <hostname> <wireguard ip> [wireguard endpoint ip]
```

#### Setup

On a freshly installed Debian with your key in /root/.ssh/authorized_keys:

```console
$ task host:setup user:dotfiles -- <hostname>
```

#### Update

```console
$ task host:setup user:dotfiles -- <hostname>
```
