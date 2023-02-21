# Output Server IP
output "ip" {
  description = "The primary IP address of the virtual machine"
  value       = libvirt_domain.bc_vm[*].network_interface[0].addresses[0]
}

output "id" {
  description = "The unique identifier of the virtual machine"
  value       = libvirt_domain.bc_vm[*].id
}
