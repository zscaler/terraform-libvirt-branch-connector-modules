################################################################################
# Generate Cloudinit Disk from userdata
################################################################################
resource "libvirt_cloudinit_disk" "bc_cloudinit_disk" {
  count     = var.bc_count
  name      = "bc-${count.index + 1}-user_data.iso"
  user_data = element(var.user_data, count.index)
  pool      = var.pool_name
}


################################################################################
# Define Base Volume for QCOW2 backing
################################################################################
resource "libvirt_volume" "bc_base_volume" {
  name   = var.base_volume_name
  source = var.local_qcow2_path
  pool   = var.pool_name
  format = "qcow2"
}


################################################################################
# Define BC Volumes from base
################################################################################
resource "libvirt_volume" "bc_volume" {
  count          = var.bc_count
  name           = "${var.name_prefix}-vm-${count.index + 1}-${var.resource_tag}.qcow2"
  base_volume_id = libvirt_volume.bc_base_volume.id
  format         = "qcow2"
}


################################################################################
# Create Domain/Virtual Machine resources
################################################################################
resource "libvirt_domain" "bc_vm" {

  count     = var.bc_count
  name      = coalesce(var.host_name, "${var.name_prefix}-vm-${count.index + 1}-${var.resource_tag}")
  vcpu      = local.vm_cpus
  memory    = local.vm_memory
  cloudinit = element(libvirt_cloudinit_disk.bc_cloudinit_disk[*].id, count.index)

  # Management Interface
  network_interface {
    hostname       = "${var.name_prefix}-vm-${count.index + 1}-mgmt-nic-${var.resource_tag}"
    network_name   = var.management_network_name
    wait_for_lease = true
  }

  # Control Interface
  dynamic "network_interface" {
    for_each = local.control_nic
    content {
      network_name   = var.management_network_name
      wait_for_lease = false
    }
  }

  # Service Interface
  dynamic "network_interface" {
    for_each = local.service_nic_count
    content {
      network_name   = var.service_network_name
      wait_for_lease = false
    }
  }

  disk {
    volume_id = element(libvirt_volume.bc_volume[*].id, count.index)
    scsi      = true
  }

  autostart = var.autostart

  graphics {
    type        = "vnc"
    listen_type = "address"
  }
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  xml {
    xslt = <<XSL
<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" indent="yes"/>
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="/domain/devices/interface[@type='network']/model/@type">
		<xsl:attribute name="type">
			<xsl:value-of select="'${var.model_type}'"/>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
XSL
  }
}
