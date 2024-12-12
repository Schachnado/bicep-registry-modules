@description('Required. The name of the key vault.')
param keyvaultName string

@description('Required. The name of the storage account.')
param storageAccountName string

@description('Required. The name of the virtual network.')
param vnetName string

param managedIdentityName string

@allowed([
  true
  false
])
@description('Optional. Enable Hierarchical Namespace for the storage account. Default is true.')
param enableHierarchicalNamespace bool = true

module keyvault '../avm/res/key-vault/vault/main.bicep' = {
  name: 'keyvault'
  params: {
    name: keyvaultName
  }
}

module storage '../avm/res/storage/storage-account/main.bicep' = {
  name: 'storage'
  params: {
    name: storageAccountName
    enableHierarchicalNamespace: enableHierarchicalNamespace
  }
}

module vnet '../avm/res/network/virtual-network/main.bicep' = {
  name: 'vnet'
  params: {
    name: vnetName
    addressPrefixes: [
      '10.1.0.0/16'
    ]
  }
}

module managedIdentity '../avm/res/managed-identity/user-assigned-identity/main.bicep' = {
  name: 'managedIdentity'
  params: {
    name: managedIdentityName
  }
}
