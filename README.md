# 1. Create an AWS named profile

# 2. Deploy infrastructure to the AWS account with terraform from your local CLI

# 3. Connect Snyk and Gitlab & AWS and Gitlab

# 4. Add a job to the pipeline which will if there are any issues with terraform code which defines the infrastructure

# 5. Save the output of the job as "kics-results" as artifact so that it can be downloaded and reviewed

# 6. In order to save cost, make sure the report is deleted from gitlab after 1 hour

# 7. Make sure the aforementioned job fails only on findings with level "high", but proceeds if findings are level "medium" or "low"

# 8. Address any "high" level findings by updating codebase accordingly

# 9. Set this job to be allowed to fail

# 10. Add a job to the pipeline which will check if there are any secure strings like passwords or API keys in the repository

# 11. Save the output of the job as "gitleaks-report.json" as artifact so that it can be downloaded and reviewed

# 12. In order to save cost, make sure the report is deleted from gitlab after 1 hour

# 13. Address any findings by updating codebase accordingly

# 14. Create a build job which will build the docker image. Make sure the built image can be passed to the following Snyk job

# 15. In order to save cost, make sure the image is deleted from gitlab after 1 hour

# 16. Create a Snyk job which will take the image from previous job and scan it for vulnerabilities. Set the severity-threshold as "critical"

# 17. Save the output of the job as "vulnerabilities.json" as artifact

# 18. In order to save cost, make sure the report is deleted from gitlab after 1 hour

# 19. Set this job to be allowed to fail

# 20. Create a Snyk pages job which will take as input the aforementioned "vulnerabilities.json" and output results as html artifact

# 21. In order to save cost, make sure the report is deleted from gitlab after 1 hour

# 22. Push image, which was built previously in the docker build job, to the AWS ECR

# 23. Optimize the Snyk pages job to complete faster

# 24. Optimize docker build so that the image is smaller

# 25. Optimize docker build so that the build process happens faster

# 26. Create a new route for the python application called "healthcheck"

# 27. Update terraform code which defines the Load Balancer to make use of the aforementioned "healthckeck" route