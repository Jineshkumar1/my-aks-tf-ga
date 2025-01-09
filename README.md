# my-aks-cluster

Repo containing my configured AKS cluster.

### Step 1: Structuring Terraform Code

'''

Folder Structuring Terraform Code


├── .github
│   ├── workflows
├── cluster-deployment
│   ├── tfvars
├── github-deployment
│   ├── tfvars
├── modules
│   ├── aks-cluster
│   ├── azure-container-registry
│   ├── etc. etc.
├── LICENSE
├── rEADME.md
└── .gitignore

''''

### Step 2: Creating our resources for GitHub Actions.

Create a User Assigned Managed Identity for OIDC authentication.
Create federated credentials for the managed identity.
Create a Azure Storage account and container to store our state file.
Deploy the resources via the CLI


IMP Note 
User Assigned Identities use the the AzureRM provider, while App Registrations use the Azure AD provider.



#### Creating the Federated Credentials
To authenticate to Azure Services securely from GitHub Actions, we'll need to login using OpenID Connect, or OIDC.

OpenID Connect is an identity authentication protocol that's an extension of OAuth 2.0 that standardizes the process for authenticating and authorizing users when they sign in to access services. To learn more about OIDC, check out this article.

GitHub Actions can use OIDC in workflows by requesting a short-lived access token directly from Azure. This is better than using credentials, as we won't need to create credentials for GitHub to use and then duplicate them as secrets in GitHub. We can also have more granular control over how workflows can use credentials, and since access tokens are only valid for a single job, we get the benefits of rotating credentials.

When we create a federated credential for a deployment workflow, we are telling Microsoft Entra ID and GitHub to trust each other. When our GitHub Actions workflow attempts to sign in, GitHub will provide information about the workflow run so that Microsoft Entra ID can decide whether or not to allow the sign in.

For our federated credentials, we need to provide information about the issuer, subject, and audiences. The issuer is the URL of the external identity provider and must match the issuer claim of the external token. The subject is the identifier of the external software workload and must match the sub or subject claim of the external token being shared. Each IdP uses their own subject. Finally, audiences lists the audiences that can appear in the external token.

To store the audience and issuer values, I've added these to a local.tf file like so:

'''
locals {
  default_audience_name = "api://AzureADTokenExchange"
  github_issuer_url     = "https://token.actions.githubusercontent.com"
}
'''



-----

For our User Assigned managed identity, we need the following secrets:

GitHub Secret	User Assigned Managed Identity Property
AZURE_CLIENT_ID	Client ID
AZURE_SUBSCRIPTION_ID	Subscription ID
AZURE_TENANT_ID	Directory (tenant) ID
For our storage account, we need the following secrets:

GitHub Secret	Storage Account Property
BACKEND_AZURE_RESOURCE_GROUP_NAME	Name of the resource group that the storage account has been deployed to.
BACKEND_AZURE_STORAGE_ACCOUNT_NAME	Name of the Storage Account used to store the .tfstate file.
BACKEND_AZURE_STORAGE_ACCOUNT_CONTAINER_NAME	Name of the Blob Container used to store the .tfstate file.