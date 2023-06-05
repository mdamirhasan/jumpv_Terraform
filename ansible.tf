resource "null_resource" "instance-id" {
      depends_on = [
         aws_instance.jumpv,
#         aws_cloudfront_distribution.example
      ]

      triggers = {
        always_run = "${timestamp()}"
      }

    provisioner "local-exec" {
    command = "sed -i '/^instance_id:/d' /home/shtlp0133/Music/office-projects/Jumpv/jumpv_Ansible/roles/terraform/vars/main.yml &&   echo 'instance_id: \"${aws_instance.jumpv.id}\"' >> /home/shtlp0133/Music/office-projects/Jumpv/jumpv_Ansible/roles/terraform/vars/main.yml"
  }
}

resource "null_resource" "ansible-host" {
      depends_on = [
         aws_instance.jumpv,
#         aws_cloudfront_distribution.example
      ]

      triggers = {
        always_run = "${timestamp()}"
      }
      provisioner "local-exec" {
        command = "sed -e 's/#ipaddress1/${aws_instance.jumpv.public_ip}/'  ansible_host > /home/shtlp0133/Music/office-projects/Jumpv/jumpv_Ansible/inventory/test/hosts"
      }
}

resource "null_resource" "ansible-playbook" {
      depends_on = [
        null_resource.ansible-host,
#        aws_cloudfront_distribution.example
      ]

      triggers = {
        always_run = "${timestamp()}"
      }

      provisioner "local-exec" {
        command = <<EOF
           cd /home/shtlp0133/Music/office-projects/Jumpv/jumpv_Ansible && ansible-playbook -i inventory/test/hosts jumpv.yml --private-key=~/Downloads/jumpv.pem -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"

EOF
    }
}

#This is the code when you will run ansible playbook on the server:

# resource "null_resource" "ansible-host" {

#   depends_on = [
#     aws_instance.jumpv
#   ]
#   triggers = {
#     always_run = "${timestamp()}"
#   }
#   provisioner "local-exec" {
#     command = "sed -e 's/#ipaddress1/${aws_instance.jumpv.public_ip}/'  ansible_host > hosts"
#   }
# }

