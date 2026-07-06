# 1. Déclaration des dépendances (Le Provider)
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

# 2. Déclaration d'une variable pour l'adresse du serveur DNS
variable "dns_primary_ip" {
  description = "Adresse IP du serveur de resolution DNS primaire"
  type        = string
  default     = "192.168.56.200"
}

# 3. Déclaration de notre ressource (Création du fichier DNS)
resource "local_file" "dns_config" {
  filename = "/tmp/dns_config.txt"
  content  = "nameserver ${var.dns_primary_ip}\nnameserver 8.8.8.8"
}
