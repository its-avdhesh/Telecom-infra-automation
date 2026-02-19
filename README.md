#  IaC Provisioning for Telecom System

### **Group No:** D12 - Group 01  
### **Project No:** DO-39

---

##  Project Description
This project focuses on **Automating the Infrastructure Provisioning** for a large-scale Telecom system. By leveraging **Infrastructure as Code (IaC)** tools like Terraform, we eliminate manual configuration errors and ensure a repeatable, scalable environment setup. The project involves deploying local Docker environments and Kubernetes clusters to host critical telecom microservices (e.g., Billing, Network Management) with zero human intervention in the setup phase.

##  Project Overview
The system acts as a bridge between high-level telecom service requirements and low-level cloud/local infrastructure. It consists of a **Management Portal** built on Node.js that serves as a control plane. When a deployment is triggered, the system utilizes **GitHub Actions** and **Terraform** to provision the necessary containers and orchestrate them via **Kubernetes**. The entire lifecycle—from code commit to live service—is managed through a robust CI/CD pipeline.

##  Objectives
* **Automation**: To replace manual server configuration with automated, script-based deployments.
* **Consistency**: To ensure that the development, testing, and production environments are identical.
* **Scalability**: To allow the telecom system to handle varying loads by scaling containers dynamically.
* **Security**: To implement secure access controls and encrypted state management for infrastructure.



##  Tech Stack

| Category | Tools/Technologies Used |
| :--- | :--- |
| **IaC & Orchestration** | Terraform, Kubernetes (K8s), Docker |
| **CI/CD & Automation** | GitHub Actions, Git |
| **Backend (Control Plane)** | Node.js, Express.js |
| **Database & Auth** | MongoDB (Mongoose), JWT, Bcrypt |
| **Frontend/Templating** | EJS (Embedded JavaScript) |
| **Environment Mgmt** | Dotenv, Cookie-parser, Multer |

##  Key Features
* **Automated Infrastructure**: Script-based setup of Docker hosts and K8s nodes.
* **Secure Authentication**: Admin portal protected by JWT and Bcrypt password hashing.
* **State Management**: Real-time tracking of infrastructure "Reality" vs "Code" using Terraform State.
* **Continuous Deployment**: Automated build and push of Docker images via GitHub Actions.
* **Microservice Hosting**: Specifically optimized for hosting Telecom services like Billing and SMS gateways.



##  Group Members
1. Ayushi Pal
2. Aayushi Solanki
3. Avdhesh Bhadoriya
4. Ramji Soni
5. Kanak Kumari
   
##  Conclusion
The **IaC Provisioning for Telecomm System** demonstrates the power of modern DevOps practices in mission-critical industries. By moving away from manual "snowflake" servers to version-controlled infrastructure, we have achieved a setup that is **90% faster** to deploy and significantly more resilient to failures. This project serves as a foundation for building self-healing telecom networks that can scale globally with a single click.

---
*Developed as part of the Skill Based Course at Medicaps University in collaboration with Datagami.*
