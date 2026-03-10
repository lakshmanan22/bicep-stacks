@description('Location for all resources')
param location string

@description('Storage account name (must be globally unique)')
param storageAccountName string

@description('Resource tags')
param tags object = {}

/*
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    allowCrossTenantReplication: false   // ✅ REQUIRED FOR LTIM
    publicNetworkAccess: 'Disabled'

    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
}

output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
*/
