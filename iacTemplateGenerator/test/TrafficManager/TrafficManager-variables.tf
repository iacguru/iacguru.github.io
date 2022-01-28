# Traffic Manager Profile Variables

variable "resource_group_name" {
    type = string
    description = "(Required) Specifies the Name of the Resource Group within which the Traffic manager should exist. Changing this forces a new resource to be created"
    default = ""
}

variable "traffic_manager_profile_name" {
    type = string
    description = "(Required) Specifies the Name of the  Traffic manager profile"
    default = ""
}

variable "enable_for_priority_routing" {
    type = bool
    description = "Condition to enable priority routing method "
    default = true
}

variable "enable_for_Weighted_routing" {
    type = bool
    description = "Condition to enable weighted routing method "
    default = false
}

variable "enable_for_Performance_routing" {
    type = bool
    description = "Condition to enable performance routing method "
    default = false
}

variable "enable_for_multivalue_routing" {
    type = bool
    description = "Condition to enable multivalue routing method "
    default = false
}

variable "enable_for_subnet_routing" {
    type = bool
    description = "Condition to enable subnet routing method "
    default = false
}

variable "enable_for_geographic_routing" {
    type = bool
    description = "Condition to enable geographic routing method "
    default = false
}

# Dns configuration Variables

variable "dns_ttl_value" {
    type = number
    description = "TTL value of the profile used for dns config"
    default = 100
}

# Monitor configuration Varibles

# Supported values_HTTP,HTTPS and TCP
variable "protocol" {
    type = string
    description = "Protocol used by the monitoring checks."
    default = "http"
}

variable "port_no" {
    type = number
    description = "Port number used by the monitoring checks"
    default = 80
}

# Required when protocol set to HTTPS and HTTP.Cannot be set when protocol is TCP
variable "path" {
    type = string
    description = "Path used by the monitoring checks"
    default = "/"
}

variable "interval_in_seconds" {
    type = number
    description = "Time interval between endpoint health probes"
    default = 30
}

#Minimum value is 5 and should be less than interval value
variable "timeout_in_seconds" {
    type = number
    description = "Time required before endpoint health probe times out"
    default = 10
}

# Value should be between 0 and 9
variable "tolerated_no_of_failures" {
    type = number
    description = "No of health probe failures tolerated before endpoint failure is triggered"
    default = 3
}

#trafficmanager endpoint Variables

variable "primary_endpoint_name" {
    type = string
    description = "The name of the primary endpoint"
    default = ""

}

variable "failover_endpoint_name" {
    type = string
    description = "The name of the primary endpoint"
    default = ""

}

# supported endpoint types_azureEndpoints,nestedEndpoints,ExternalEndpoints
variable "enable_for_azure_endpoint" {
    type = bool
    description = "Condition to enable azure Endpoint type"
    default = true
}
variable "enable_for_external_endpoint" {
    type = bool
    description = "Condition to enable external Endpoint type"
    default = true
}
variable "enable_for_nested_endpoint" {
    type = bool
    description = "Condition to enable nested Endpoint type"
    default = true
}

variable "primary_priority_value" {
    type = number
    description = "Priority Value of primary azure target resource to connect to"
    
}

variable "failover_priority_value" {
    type = number
    description = "Priority Value of failover azure target resource to connect to"
}

variable "primary_weight_value" {
    type = number
    description = "Weight Value of primary azure target resource to connect to"
}

variable "failover_weight_value" {
    type = number
    description = "Weight Value of failover azure target resource to connect to"
}

variable "enable_app_service" {
    type = bool
    description = "Condition to enable app service"

}

variable "enable_ip_add" {
    type = bool
    description = "Condition to enable public ip address"

}

variable "primary_app_service_name" {
    type = string
    description = "Name of primary app service"
}

variable "failover_app_service_name" {
    type = string
    description = "Name of failover app service"
    default = ""
}
variable "app_service_rg" {
    type = string
    description = "Resource group of app service"
    default = ""
}
variable "primary_public_ip_add_name" {
    type = string
    description = "Name of primary ip address"
    default = ""
}
variable "failover_public_ip_add_name" {
    type = string
    description = "Name of failover public ip address"
    default = ""
}
variable "public_ip_add_rg" {
    type = string
    description = "Resource group where public ip exists"
    default = ""
}
variable "failover_fqdn" {
    type = string
    description = "fqdn of primary endpoint"
}
variable "primary_fqdn" {
    type = string
    description = "fqdn of primary endpoint"
    default = ""
}

variable "primary_endpoint_location" {
    type = string
    description = "Locaton of primary endpoint service"
    default = ""
}
variable "failover_endpoint_location" {
    type = string
    description = "Locaton of failover endpoint service"
    default = ""
}
