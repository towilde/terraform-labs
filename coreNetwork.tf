resource "azurerm_resource_group" "core" {
   name         = "core"
   location     = "${var.loc}"
   tags         = "${var.tags}"
}



resource "azurerm_public_ip" "vpnGatewayPublicIp" {
  name                          = "vpnGatewayPublicIp"
  resource_group_name           = "${azurerm_resource_group.core.name}"
  location                      = "${azurerm_resource_group.core.location}"
  public_ip_address_allocation  = "Dynamic"
}

resource "azurerm_virtual_network" "core" {
  name                = "core"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.core.location}"
  resource_group_name = "${azurerm_resource_group.core.name}"
  dns_servers         = ["1.1.1.1","1.0.0.1"]
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = "${azurerm_resource_group.core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
  address_prefix       = "10.0.0.0/24"

}

resource "azurerm_subnet" "Training" {
  name                 = "Training"
  resource_group_name  = "${azurerm_resource_group.core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
  address_prefix       = "10.0.1.0/24"

}

resource "azurerm_subnet" "dev" {
  name                 = "dev"
  resource_group_name  = "${azurerm_resource_group.core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
  address_prefix       = "10.0.2.0/24"

}

 #   resource "azurerm_virtual_network_gateway" "vpnGwConfig1" {
 #   name                 = "vpnGwConfig1"
 #   resource_group_name  = "${azurerm_resource_group.core.name}"
 #   location              = "${azurerm_resource_group.core.location}"
 #    vpn_type = "RouteBased"
 #   enable_bgp = true
 #   sku = "Basic"
 #   type = "Vpn"
 #       ip_configuration {
 #           name                            = "vpnGwConfig"
 #           public_ip_address_id            = "${azurerm_public_ip.vpnGatewayPublicIp.id}"
 #       private_ip_address_allocation   = "Dynamic"
 #           subnet_id                       = "${azurerm_subnet.GatewaySubnet.id}"
 #       }
    
 #   }
