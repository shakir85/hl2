`ansible-playbook -u ubuntu -i <IP>, --private-key <SSHKEY> playbook.yml`

```ascii
`ansible
	|_ roles
	|	|_ role1 `e.g. common_config
	|	|_ role2 `e.g. common_pkgs
	|	|_ role3 `e.g. docker
	|	|...
	|
	|___host1.yml (e.g. implements role1+ role2)
	|___host2.yml (e.g. implements role1+ role2 + role3)
	|___host3.yml (e.g. implements role1+ installs specific sw)
	.
	.
	.
```
