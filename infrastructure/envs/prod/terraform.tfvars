# This file contains the variables for the Azure infrastructure deployment.

# This section defines the environment var. 
environment = "prod"


# This section defines the variables for the Resource Group
resource_group_name     = "MicroService-Project-RG"
resource_group_location = "East US"


# This section defines the variables for the virtual network.
virtual_network_name    = "application-vnet"
virtual_network_address = "10.224.0.0/15"

# This section defines the variables for the subnets in the virtual network.
infra_subnet_name    = "infra-subnet"
infra_subnet_address = "10.225.0.0/24"
aks_subnet_name      = "aks-subnet"
aks_subnet_address   = "10.224.0.0/16"
db_subnet_name       = "db-subnet"
db_subnet_address    = "10.225.1.0/24"
vpn_subnet_name      = "GatewaySubnet"
vpn_subnet_address   = "10.225.2.0/24"
nat_subnet_name      = "nat-subnet"
nat_subnet_address   = "10.225.3.0/24"


# This section defines the variables for the Azure Container Registry (ACR).
acr_name = "mgcontainerregistryklayytech" # Must be globally unique
acr_sku  = "Premium"                      # Options: Basic, Standard, Premium


# This section defines the variables for the MySQL server.
mysql_name          = "rabbit-mysql-database"                # Must be globally unique
mysql_user          = "mysqladmin"                           # Admin username
mysql_version       = "8.0.21"                               # MySQL version
mysql_replica_name  = "rabbit-mysql-replica"                 # Must be globally unique
mysql_sku           = "GP_Standard_D2ds_v4"                  # Compute tier
mysql_dns_zone_name = "privatelink.mysql.database.azure.com" # DNS zone for private link


# This section defines the variables for the Virtual Machine.
agent_vm_name            = "agent-vm"     # Name of the VM
agent_vm_size            = "Standard_F2"  # VM compute size
agent_vm_admin_username  = "mahmoud"      # Admin username
agent_vm_os_disk_type    = "Standard_LRS" # Disk type (HDD/SSD/Premium)
agent_vm_os_disk_size_gb = 64             # OS Disk size in GB
agent_vm_image_sku       = "22_04-lts"    # OS Image SKU (Ubuntu)
agent_private_ip         = "10.225.0.70"  # Static private IP for the VM


# This section defines the variables for the AKS cluster.
aks_name         = "rabbit-aks-cluster"   # Name of the AKS cluster
aks_version      = "1.32.6"               # Kubernetes version
aks_resources_rg = "rabbit-aks-resources" # Resource group for AKS resources
aks_sku          = "Standard"             # AKS SKU (Free/Basic/Standard)

agent_pool_name           = "agentpool"        # Name of the agent pool
agent_pool_vm_size        = "Standard_D8ds_v5" # VM size for the agent nodes
agent_pool_node_count     = 2                  # Initial number of nodes
agent_pool_node_min_count = 2                  # Minimum number of nodes for autoscaling
agent_pool_node_max_count = 3                  # Maximum number of nodes for autoscaling
agent_pool_os_sku         = "Ubuntu"           # OS SKU for the agent nodes
agent_pool_os_disk_type   = "Ephemeral"        # OS Disk type for the agent nodes
agent_pool_os_disk_size   = 30                 # OS Disk size in GB for the agent nodes
agent_pool_pods_node      = 110                # Maximum number of pods per node

user_pool_name           = "userpool"         # Name of the user pool
user_pool_vm_size        = "Standard_D8ds_v5" # VM size for the user nodes
user_pool_node_count     = 2                  # Initial number of nodes
user_pool_node_min_count = 2                  # Minimum number of nodes for autoscaling
user_pool_node_max_count = 3                  # Maximum number of nodes for autoscaling
user_pool_os_sku         = "Ubuntu"           # OS SKU for the user nodes
user_pool_os_disk_type   = "Ephemeral"        # OS Disk type for the user nodes
user_pool_os_disk_size   = 30                 # OS Disk size in GB for the user nodes
user_pool_pods_node      = 110                # Maximum number of pods per node


# This section defines the variables for the Front Door.
frontdoor_name          = "frontdoor-aks-apps"       # Must be globally unique
frontdoor_endpoint_name = "endpoint-aks-ingress"     # Name of the Front Door endpoint
origin_group_name       = "origin-group-aks-ingress" # Name of the origin group
origin_name             = "origin-aks-ingress"       # Name of the origin
route_name              = "route-aks-ingress"        # Name of the route