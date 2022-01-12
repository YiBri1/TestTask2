# TestTask2

Goals of the task:
1. Build a small website 
2. Deploy it and build a pipeline for it

Steps:
1. Code. I've built a small HTML site, it's saved in my_data.sh 
2. In this project AWS is used as a cloud platform, where we'll get our webserver
3. Infrastracture as a code. To automate launch and describe the required webserver I used terraform. Code is saved in terfile.tf
4. When the server is running, we need to attach our ns records to DNS. In my particular case, DNS is hosted on http:namecheap.com  
5. For building a pipeline I used Jenkins. When any file is changed in GIT, it uses webhook to catch changes and run a simple test for my_data.sh. Right after that, deployment process finishes reaching GitHub
