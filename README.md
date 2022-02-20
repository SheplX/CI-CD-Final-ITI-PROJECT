![Image](https://github.com/SheplX/CI-CD-Final-ITI-Task/blob/main/ScreenShots/Simple%20DevOps%20Project%20-%20CI_CD%20with%20Git%2C%20Jenkins%2C%20Ansible%2C%20Docker%20and%20Kubernetes%20_%20Simpliv.png)

# CI/CD FULL PIPELINE STEP 

- Welcome there from ITI Students !
- Today we would like to share a full pipeline process starts from terraform infrastructure step till application deployment as a final step.
- In this long process, we used a different DevOps tools like :
 `Terraform - Ansible - GCP - Git - Jenkins - Kubernetes - Docker`

# SOME INFO ABOUT THE INFRASTRUCTURE BUILD : 

- Cuz the secruity is always our goal, we built all this infrastructure privatly, so our application can run under a good layers of the security.
- The used infrastructure here is a private vpc & subnet & instance & GKE cluster.
- We also made all the pipeline steps running on the instance and used it as a Jenkins agent.

# Requirements :

Well, we used here Google Cloud Provider so u need :
-  configured gcp account with billing account enabled
-  configured project 

# Installation :

- Download the source code :
```
git clone https://github.com/SheplX/CI-CD-Final-ITI-Task.git
```
- Navigate to [Terraform](https://github.com/SheplX/CI-CD-Final-ITI-Task/tree/main/Terraform) folder run the following commands:
```
terraform init
terraform plan
terraform apply
```
- Navigate to GCP, check instances, ssh into jenkins one then install Ansible:
```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
- Make sure that u are at home directory, Apply Ansible PlayBook For setting jenkins and its agent:
```
ansible-playbook Ansible.yaml
```
- Check LoadbalancerIP servies and run it on port 8080 for Jenkins UI using this command:
```
kubectl get all
```
- Now u can setting ur pipeline and connect it to this repo for building the application and deploying it.

# FINALY

- Thanks for checking my content, any quesions ? u can find me [Here](https://www.facebook.com/shepl.dev/)
- During our steps, we loved to share some captures about every step info, u can check them [Here](https://github.com/SheplX/CI-CD-Final-ITI-Task/tree/main/ScreenShots)

![Image](https://github.com/SheplX/CI-CD-Final-ITI-Task/blob/main/ScreenShots/Screenshot%20from%202022-02-20%2005-09-19.png)
