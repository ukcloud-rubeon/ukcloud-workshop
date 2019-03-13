The plan for next week

Tuesday on-site

Automation work

- started using Heat

- access to API, create a few VPNs

- take a look at some of the scripts

- Create pre-reqs

create resource for VM

Trying to get his head around why some things work, and some things don't

In preparation:

- heat troubleshooting, best practices



Heat Topics

- dependencies in templates
- example: spinning up HAproxy
- spin up VM, and then install packages
- Setting security group rules

Terraform
- Security Groups
-

DevOps
- Configuration Management
- Code versioning and management
- GitFlow documentation


OpenStack Server Groups

Server groups define affinity policty

- openstack server group create --policy <affinity|anti-affinity> <groupname>
- openstack server create [...] --group <groupname>



## Demo Templates

- 01 Basic

Demonstrates the creation of a basic, 1-server infrastructure using OpenStack
Heat.

- 02 MachineConfig

Adds a `user_data` element to the template, installing software and configuring
a web server.  Also separates out the parameters into a parameters file.
