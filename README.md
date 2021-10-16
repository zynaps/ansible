## Usage

#### Setup

On a freshly installed Debian with your key in /root/.ssh/authorized_keys:

```console
$ task host:bootstrap host:setup dotfiles:add -- <hostname>
```

#### Update

```console
$ task host:setup dotfiles:update -- <hostname>
```
