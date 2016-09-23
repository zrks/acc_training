In order to launch and access instance:

```bash
$ cd acc_training
$ vagrant up
$ vagrant ssh
```

For provisioned items check provision.sh.

For opened ports check Vagrantfile config.vm.network part.

To increase memory - adjust vb.memory block.

To get bash examples from within vagrant do:
```bash
$ cp -r /vagrant/learn_bash ~/
```
This will copy bash scripts to home directory.

In case of questions contact me via slack.
