# AKS Cluster Identity id
output "aks_cluster_identity_id" {
  value = azurerm_user_assigned_identity.aks_identity.principal_id
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_cluster_kube_config_host" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive = true
}

output "aks_cluster_kube_config_client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "aks_cluster_kube_config_client_key" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive = true
}

output "aks_cluster_kube_config_cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive = true
}