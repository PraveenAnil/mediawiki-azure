# MediaWiki Deployment in Azure

MediaWiki is a free and open-source wiki software package written in PHP. It
serves as the platform for Wikipedia and the other Wikimedia projects, used
by hundreds of millions of people each month. MediaWiki is localised in over
350 languages and its reliability and robust feature set have earned it a large
and vibrant community of third-party users and developers.

MediaWiki is:

* feature-rich and extensible, both on-wiki and with hundreds of extensions;
* scalable and suitable for both small and large sites;
* simple to install, working on most hardware/software combinations; and
* available in your language.

## Prerequisites :

  - You should have a Microsoft Azure account with atleast contributor level role on Resource Group level scope.
  - You should have access to an SSH Client or access to CloudShell for Azure to connect to the MediaWiki deployed linux machines

## Deploy MediaWiki in Azure

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPraveenAnil%2Fmediawiki-azure%2Fmain%2Fautomation%2Fdeploy-01.json)

You can click on the above button to deploy directly in Azure.

The deployment takes between 5 to 10 minutes and the output of the template includes the following details:

1. MediaWiki URL
2. MediaWiki VM DNS Name
3. mediaWiki VM Username
4. mediaWiki VM Password
5. mediaWiki DB Username
6. mediaWiki DB Password
7. mediaWiki DBName
8. mySQL Admin Username
9. mySQL Password

## Post Deployment Steps

1. Once the deployment is complete, from the outputs, navigate to MediaWiki URL and configure the setup, and proceed through the setup steps. 
Choose the MariaDB option when prompted for a database server, and enter the database name, username, and user password from the output of the deployment. 
2. Login to the VM instance using the DNSName:50001. An inbound Nat Rule is configured within the load balancer to allow ssh to the instance.
3. Download the LocalSettings.php file when prompted at the end of the setup process, then move it or copy its contents to /var/www/html/w/LocalSettings.php
4. Adjust the file’s permissions:  sudo chmod 664 /var/www/html/w/LocalSettings.php

## Deployment Files:

  This repository contain the following files.

  - automation/deploy-01.json - This is an Azure Resource Manager Template file which includes the definition to provision the resources in Azure cloud.
  - automation/deploy-01.parameters.json - This is an Azure Resource Manager Template Parameters file which includes the values to the parameters in deploy-01.json file
  - script01.sh and script02.sh - These are shell script, that performs all the activities starting from installing required packages to publish the service.


## Architecture

Currently, the MediaWiki is deployed as a standalone instance in VMSS with only 1 count.

The database is locally installed within the VM using the scripts. 

## Limitation / Known Issues

If the instance count is more than 1, then the database has to be hosted separarately, ideally in a Managed Service within Azure to ensure this can be scaled as required.

SSH to VM instance is not working as expected.

## CI/CD

This template supports enabling through CI/CD pipelines such as Azure DevOps Pipelines

