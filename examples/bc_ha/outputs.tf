locals {

  testbedconfig = <<TB
SSH to BC-1 management
ssh -i ${try(trim(local_file.private_key[0].filename, "../"), "<user-ssh-key-pem-file>")} zsroot@${module.bc_vm.ip[0]}

SSH to BC-2 management
ssh -i ${try(trim(local_file.private_key[0].filename, "../"), "<user-ssh-key-pem-file>")} zsroot@${module.bc_vm.ip[1]}

All Branch Connector Instance IDs:
${join("\n", module.bc_vm.id)}

BC-1 Primary/Mgmt IP
${module.bc_vm.ip[0]}

BC-2 Primary/Mgmt IP
${module.bc_vm.ip[1]}

TB
}

output "testbedconfig" {
  description = "Output of of all exported attributes to be written to a local file"
  value       = local.testbedconfig
}

resource "local_file" "testbed" {
  content  = local.testbedconfig
  filename = "../testbed.txt"
}
