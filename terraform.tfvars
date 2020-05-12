/*
Supported variables in this files are as follows:

location
resource_group_name
winagent_instances_count
network_address_space
address_prefix

*/

resource_group_name      = "win-agent"
network_address_space    = "192.168.200.0/22"
address_prefix           = "192.168.200.0/24"
winagent_instances_count = 3
