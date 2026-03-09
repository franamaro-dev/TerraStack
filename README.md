# TerraStack

> **Infrastructure-as-Code (Terraform/Ansible) templates for zero-trust FinTech deployments.**

<div align="center">
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white" />
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
  <img src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" />
</div>

## ⚠️ El Problema
Los despliegues manuales mediante SSH rompen las cadenas de custodia, fallan en las auditorías técnicas (ISO 27001), y dificultan enormemente la escalabilidad horizontal en entornos transaccionales como VeriFactu o TicketBAI.

## ⚡ La Solución (Infraestructura como Código)
**TerraStack** es la receta oficial para poner en producción de forma orquestada la suite `VeriStack` y `FlowNode`.
Divide la topología en dos fases deterministas:
1. **Provisioning (Terraform):** Genera redes privadas virtuales (VPC), instancias seguras (Linux Hardened) y aplica *Security Groups* bajo la premisa de *Default Deny* (Zero-Trust).
2. **Configuration Management (Ansible):** Orquesta los contenedores Docker dentro de la VLAN generada, enlazando APIs con Brokers (Redis) de forma ciega y segura al exterior.

## 🚀 Uso Rápido (Dry Run)

```bash
# 1. Validar plan de infraestructura
cd terraform
terraform init
terraform plan -out=fintech_prod.tfplan

# 2. Configurar servidores e inyectar Docker Compose Stack
cd ../ansible
ansible-playbook -i inventory/production.ini playbooks/deploy_stack.yml --check
```

## 🔒 Postura de Seguridad (Zero-Trust)
* Los puertos de bases de datos de vectores (Qdrant) y colas (Redis) **nunca** están expuestos a redes públicas.
* SSH reforzado y restingido solo para IPs de control.
* Despliegue garantizado mediante *Immutable Infrastructure*.
