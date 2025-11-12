resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks"

  azure_policy_enabled              = true
  http_application_routing_enabled  = false
  local_account_disabled            = false
  support_plan                      = "KubernetesOfficial"
  kubernetes_version                = var.aks_version
  node_resource_group               = var.aks_resources_rg
  private_cluster_enabled           = true     # Set to true to enable private cluster
  private_dns_zone_id               = "System" # Set to "System" to enable private cluster with private DNS zone
  role_based_access_control_enabled = true
  sku_tier                          = var.aks_sku

  bootstrap_profile {
    container_registry_id = var.acr_id
  }

  default_node_pool {
    name                         = var.agent_pool_name
    fips_enabled                 = false
    kubelet_disk_type            = "OS"
    max_count                    = var.agent_pool_node_max_count
    min_count                    = var.agent_pool_node_min_count
    node_count                   = var.agent_pool_node_count
    max_pods                     = var.agent_pool_pods_node
    only_critical_addons_enabled = true
    os_disk_size_gb              = var.agent_pool_os_disk_size
    os_disk_type                 = var.agent_pool_os_disk_type
    os_sku                       = var.agent_pool_os_sku
    scale_down_mode              = "Delete"
    type                         = "VirtualMachineScaleSets"
    ultra_ssd_enabled            = false
    vm_size                      = var.agent_pool_vm_size
    zones                        = [1, 2, 3]
    vnet_subnet_id               = var.aks_subnet_id
    auto_scaling_enabled         = true
  }

  network_profile {
    dns_service_ip    = "10.0.0.10"
    ip_versions       = ["IPv4"]
    load_balancer_sku = "standard"
    network_plugin    = "azure"
    network_policy    = "azure"
    outbound_type     = "userAssignedNATGateway"
    service_cidr      = "10.0.0.0/16"
    service_cidrs     = ["10.0.0.0/16"]
  }

  # 🔑 Use your custom identity for kubelet
  kubelet_identity {
    client_id                 = azurerm_user_assigned_identity.aks_identity.client_id
    object_id                 = azurerm_user_assigned_identity.aks_identity.principal_id
    user_assigned_identity_id = azurerm_user_assigned_identity.aks_identity.id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  tags = {
    Environment = "Production"
  }
}