## Usage

#### Setup

On a freshly installed Debian with your key in /root/.ssh/authorized_keys:

```console
$ task host:bootstrap host:setup dotfiles:add -- <hostname>
```

or:

```console
$ bin/hosts_setup.sh <hostname> ...
```

or like this and you can select hosts one by one:

```console
$ bin/hosts_setup.sh
```

#### Update

```console
$ task host:setup dotfiles:update -- <hostname>
```
