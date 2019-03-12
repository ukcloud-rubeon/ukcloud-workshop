variable "cloud_name" {
  default = "demo-cor"
}

variable "ubuntu" {
  default = {
      demo-cor = "Ubuntu-18.04-AMD64-LTS",
      demo-frn =  "Ubuntu-18.04-LTS"
  }
}

variable "cidr" {
  default = {
      app = "192.168.2.0/24",
      dmz = "192.168.1.0/24"
  }
}

variable "allowed_ports_dmz" {
  default = [
      22,
      80,
      443,
      8080,
      9090
  ]
}

variable "allowed_ports_app" {
  default = [
      22,
      8080,
      3306,
      3307
  ]
}
