## Usage

#### Add host common playbook and wireguard variables

```console
$ task host:add -- <wireguard ip> <wireguard endpoint ip> <hostname>
```

#### Setup

On a freshly installed Debian with your key in /root/.ssh/authorized_keys:

```console
$ task host:bootstrap host:setup user:dotfiles -- <hostname>
```

#### Update

```console
$ task host:setup user:dotfiles -- <hostname>
```
