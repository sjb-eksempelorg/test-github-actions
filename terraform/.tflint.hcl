plugin "azurerm" {
    enabled = true
    version = "0.29.0"
    source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# Sjekk at variabelnavn følger snake_case (f.eks. storage_name, ikke storageName)
rule "terraform_naming_convention" {
  enabled = true

  resource {
    format = "snake_case"
  }
  
  variable {
    format = "snake_case"
  }
  
  output {
    format = "snake_case"
  }

}

# Sjekk at alle variabler har en beskrivelse
rule "terraform_documented_variables" {
  enabled = true
}

# Sjekk at alle variabler har en type (string, number, etc.)
rule "terraform_typed_variables" {
  enabled = true
}

# Sjekk at storage account navn er gyldig
rule "azurerm_storage_account_invalid_name" {
  enabled = true
}