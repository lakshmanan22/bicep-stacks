@description('Location for all resources')
param location string = resourceGroup().location

@description('Storage account name (must be globally unique)')
param storageAccountName string

@description('Network Security Group name')
param nsgName string

@description('Source IP/CIDR allowed for SSH')
param sshSourceIp string

@description('Resource tags')
param tags object = {}

// ==============================
// Storage Account
// ==============================
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
    allowCrossTenantReplication: false
    publicNetworkAccess: 'Disabled'
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
}

// ==============================
// Network Security Group + Rule
// ==============================
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: nsgName
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'Allow-SSH'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: sshSourceIp
          destinationAddressPrefix: '10.0.0.0/16' // ✅ policy compliant
        }
      }
    ]
  }
}

// ==============================
// Outputs
// ==============================
output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
output nsgId string = nsg.id
