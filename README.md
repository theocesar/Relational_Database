# Relational_Database

Database created using the MySQL language.
 
## Objective:

The goal of this project was to create a fictitious database based on a real-world pharmaceutical company database.

## Description of the cenary:

A fictitious pharmaceutical company is responsible for the manipulation, research, and creation of medicines, ranging from those that require a prescription to those that do not. These drugs are identified by name and code and are registered in one of the company's divisions.
 
To manipulate the drugs, the organization has agreements with several suppliers (identified by company name, CNPJ, and location), which enable the delivery of the necessary materials for the production process.

When the drugs are processed, they are collected at the production site by a transportation company outsourced (identified by company name, CPNJ, and location) by the organization.

Then, the company receives purchase orders (identified by a unique order number and the purchase amount) for these drugs from several of the company's partner pharmacies (identified by company name, CNPJ, and location) and, upon completion, the drugs are transported to the pharmacies.

These stores sell the drugs to the population and, at the end of each month, pay a percentage of the income back to the company. This is because they pay well below market value in their purchase orders and therefore pay a percentage of their profit back to the company.
 
Moreover, in order to present transparency in its activities, the company has signed an agreement with several inspection agencies (characterized by name, acronym and ID), which every month perform their inspections in the various departments of the company. 

The pharmaceutical company is identified by its primary organizational division, the departments, in which the drugs are registered: These divisions are identified by name and acronym. Each department has only one manager, but may have several other deputy managers, who report directly to the first mentioned. The managers and sub-managers are identified by name, position, and time in the position. Each of the departments is subdivided into sectors, which are identified by name, unique number and assignment. A sector is managed by one and only one deputy manager. 

Within a department there may be several sectors or just one, depending on the corporate scope of the department, which will also influence the number of deputy managers.

For employees who are not managers or deputy managers, the company requires that their full name, CPF, RG, cell phone, e-mail, home address, salary, and position be registered. Each individual belongs to only one sector, and may eventually change from one sector to another, as well as from one department to another.

## Conceptual Data Model:


## Logic Data Model:

TBDepartamento (sigla, nome)

TBOrgaos_fiscalizadores(sigla, ID, nome)

TBFiscaliza(sigla_Dep, sigla_Org)

	sigla_Dep REF TBDepartamento
 
	sigla_Org REF TBOrgaos_fiscalizadores
 
TBSetor (atribuicao, numero, nome, sigla_Dep)

	sigla_Dep REF TBDepartamento
 
TBEmpregado (CPF, RG, celular, e-mail, nome completo, salario, funcao, sigla_Dep, atribuicao_Set)

	sigla_Dep REF TBDepartamento
 
	atribuicao_Set REF TBSetor
 
	funcao REF TBfuncao
 
TBFuncao(descricao, codigo)

TBFornecedor (CNPJ, localizacao, nome)

TBProduto (Codigo, Nome, sigla_Dep)

	sigla_Dep REF TBDepartamento
 
TBFornece (cnpj_Fornec, codigo_Prod)

    cnpj_Fornec REF TBFornecedor

    codigo_Prod REF TBProduto

TBPedido (Numero, valor, local_Transp, cnpj_Farm)

	local_Transp REF TBTransportadora
 
	cnpj_Farm REF TBFarmacia
 
TBConstar (codigo_Prod, numero_Ped, quantidade)

	codigo_Prod REF TBProduto
 
	numero_Ped REF TBPedido
 
TBTransportadora (localizacao, CNPJ, nome)
         
TBFarmacia (CNPJ, nome, localizacao)
 
TBGerente (ID, cargo, sigla_Dep, cpf_Empregado)
 
	cpf_Empregado REF TBEmpregado
  
	sigla_Dep REF TBDepartamento
  
	cargo REF TBCargo
  
TBCargo(descrição, data_cargo, cargo)
 
TBSubgerente (ID, cargo, cpf_Empregado, gerente_ID)
 
	cpf_Empregado REF TBEmpregado
 
	gerente_ID REF TBGerente
  
	cargo REF TBCargo

## Functional Dependencies:

Atribuição_Set  --> [numero, nome]

CPF_Empregado --> [RG, celular, email, nome completo, salario, funcao]

Sigla_Dep --> nome

Sigla_Org --> [ID, nome]

Cnpj_Fornec --> [localização, nome]

Codigo_Prod --> nome

Numero_Ped --> valor

Local_Transp --> [CNPJ, nome]

Cnpj_ Farm --> [nome, localizacao]

ID_Ger --> cargo

ID_Subger --> cargo

Codigo_Prod, Numero_Ped --> quantidade


