![Image](https://github.com/SheplX/CI-CD-Final-ITI-Task/blob/main/ScreenShots/Enterprise%20DevOps_%20The%20Spine%20Is%20Critical%20-%20DZone%20DevOps.png)

# CI/CD FULL PIPELINE STEP 

- Welcome there from ITI Students !
- Today we would like to share a full pipeline process starts from terraform infrastructure step till application deployment as a final step.
- In this long process, we used a different DevOps tools like, `Terraform - Ansible - GCP - Git - Jenkins - Kubernetes - Docker`.

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
- Navigate to [Terraform](https://github.com/SheplX/CI-CD-Final-ITI-Task/tree/main/Terraform) folder run the following commands :
```
terraform init
terraform plan
terraform apply
```
- Navigate to GCP, check instances, ssh into jenkins one.

- Install Ansible :
```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
- Make sure that u are at home directory, Apply Ansible PlayBook For setting jenkins and its agent  :
```
ansible-playbook Ansible.yaml
```
- Check LoadbalancerIP servies and run it on port 8080 for Jenkins UI using this command :
```
kubectl get all
```
- Now u can setting ur pipeline and connect it to this repo for building the application and deploying it.

# FINALY

- Thanks for checking my content, if u have any question u can contact [Here](https://www.facebook.com/shepl.dev/)
- During our steps, we loved to share some captures about every step info, u can check them [Here](https://github.com/SheplX/CI-CD-Final-ITI-Task/tree/main/ScreenShots)

![Image](https://github.com/SheplX/CI-CD-Final-ITI-Task/blob/main/ScreenShots/Screenshot%20from%202022-02-20%2004-38-18.png)
