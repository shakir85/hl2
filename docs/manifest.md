## Intro
This file is a practical manifest that describes the conventions and concepts I follow to build and maintain my homelab infrastructure and applications.
 
Projects in this repository are practical solo DevOps projects built from scratch to help me learn by figuring out and troubleshooting things myself. 

Nothing in this repository necessarily reflects my workstyle or understanding of the enterprise-level IT environment (i.e., how I do things in my daily job). Hence the objective of a homelab is to experiment, break things, have fun and learn.

## Infrastructure
The concepts followed are:
- Infrastructure should be cattle-not-pets.
- Infrastructure should be declarative, codified, and versioned using GitOps and IaC.
- Automate as you can, and keep things sensible and straightforward.

Conventions:
- Follow tools' naming and styling conventions. 
- For other assets naming, follow [RFC1123](https://www.rfc-editor.org/rfc/rfc1123#page-13), in summary:
    - A resource name should not exceed 63 characters.
    - Contain only lowercase alphanumeric characters or '-'.
    - Start and end with alpha-numeric characters.
- Lint at the CI level to maintain consistent and readable code.
- All hosted applications should be containerized.

Tools of choice:
- Proxmox host.
- Terraform for Proxmox VMs and LXCs (S3 backend for state file).
- Ansible for CM.
- Cloud-init for VM templating (incorporate HashCorp Packer in the future for golden images).
- Version control through Gitlab (mirrored to Github).
- Gitlab CI for pipelines.
- Datadog for monitoring (with a plan to move to Grafana, Prometheus, and Loki).
