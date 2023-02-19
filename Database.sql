/*Generating the database*/
create database db_1;
use db_1;

/*Creating the tables according to the cenary and the models*/
CREATE TABLE `tbl_departamento` (
  `sigla` varchar(30) NOT NULL,
  `nome` varchar(80) NOT NULL,
  PRIMARY KEY (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_setor` (
  `numero` int NOT NULL,
  `atribuicao` varchar(100) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `sigla_dep` varchar(30) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_sigla_dep1_idx` (`sigla_dep`),
  CONSTRAINT `fk_sigla_dep1` FOREIGN KEY (`sigla_dep`) REFERENCES `tbl_departamento` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_funcao` (
  `codigo` int NOT NULL,
  `descricao` varchar(100) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_empregado` (
  `CPF` char(11) NOT NULL,
  `RG` char(12) NOT NULL,
  `Celular` char(9) NOT NULL,
  `email` varchar(80) NOT NULL,
  `salario` int NOT NULL,
  `funcao` int NOT NULL,
  `sigla_dep` varchar(30) NOT NULL,
  `num_set` int NOT NULL,
  `nome` varchar(80) NOT NULL,
  PRIMARY KEY (`CPF`),
  KEY `fk_sigla_dep2_idx` (`sigla_dep`),
  KEY `fk_funcao_idx` (`funcao`),
  KEY `fk_num_set_idx` (`num_set`),
  CONSTRAINT `fk_funcao` FOREIGN KEY (`funcao`) REFERENCES `tbl_funcao` (`codigo`),
  CONSTRAINT `fk_num_set` FOREIGN KEY (`num_set`) REFERENCES `tbl_setor` (`numero`),
  CONSTRAINT `fk_sigla_dep2` FOREIGN KEY (`sigla_dep`) REFERENCES `tbl_departamento` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_orgao_fiscalizador` (
  `sigla` varchar(30) NOT NULL,
  `ID` int NOT NULL,
  `nome` varchar(80) NOT NULL,
  PRIMARY KEY (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_fiscaliza` (
  `sigla_Org` varchar(30) NOT NULL,
  `sigla_Dep` varchar(30) NOT NULL,
  PRIMARY KEY (`sigla_Org`,`sigla_Dep`),
  KEY `fk_sigla_dep_idx` (`sigla_Dep`),
  CONSTRAINT `fk_sigla_dep` FOREIGN KEY (`sigla_Dep`) REFERENCES `tbl_departamento` (`sigla`),
  CONSTRAINT `fk_sigla_org` FOREIGN KEY (`sigla_Org`) REFERENCES `tbl_orgao_fiscalizador` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_fornecedor` (
  `CNPJ` char(14) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `localizacao` varchar(100) NOT NULL,
  PRIMARY KEY (`CNPJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_produto` (
  `codigo` int NOT NULL,
  `nome` varchar(80) NOT NULL,
  `sigla_dep` varchar(30) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_sigla_dep3_idx` (`sigla_dep`),
  CONSTRAINT `fk_sigla_dep3` FOREIGN KEY (`sigla_dep`) REFERENCES `tbl_departamento` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_fornece` (
  `cnpj_fornec` char(14) NOT NULL,
  `codigo_prod` int NOT NULL,
  PRIMARY KEY (`cnpj_fornec`,`codigo_prod`),
  KEY `fk_codigo_prod1_idx` (`codigo_prod`),
  CONSTRAINT `fk_cnpj_fornec` FOREIGN KEY (`cnpj_fornec`) REFERENCES `tbl_fornecedor` (`CNPJ`),
  CONSTRAINT `fk_codigo_prod1` FOREIGN KEY (`codigo_prod`) REFERENCES `tbl_produto` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_transportadora` (
  `CNPJ` char(14) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `localizacao` varchar(100) NOT NULL,
  PRIMARY KEY (`CNPJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_farmacia` (
  `CNPJ` char(14) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `localizacao` varchar(100) NOT NULL,
  PRIMARY KEY (`CNPJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_pedido` (
  `numero` int NOT NULL,
  `valor` int NOT NULL,
  `cnpj_transp` char(14) NOT NULL,
  `cnpj_farm` char(14) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `cnpj_transp_idx` (`cnpj_transp`),
  KEY `cnpj_farm_idx` (`cnpj_farm`),
  CONSTRAINT `cnpj_farm` FOREIGN KEY (`cnpj_farm`) REFERENCES `tbl_farmacia` (`CNPJ`),
  CONSTRAINT `cnpj_transp` FOREIGN KEY (`cnpj_transp`) REFERENCES `tbl_transportadora` (`CNPJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_constar` (
  `codigo_prod` int NOT NULL,
  `numero_ped` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`codigo_prod`,`numero_ped`),
  KEY `fk_numero_ped_idx` (`numero_ped`),
  CONSTRAINT `fk_codigo_prod` FOREIGN KEY (`codigo_prod`) REFERENCES `tbl_produto` (`codigo`),
  CONSTRAINT `fk_numero_ped` FOREIGN KEY (`numero_ped`) REFERENCES `tbl_pedido` (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_cargo` (
  `codigo` int NOT NULL,
  `descricao` varchar(100) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_gerente` (
  `ID` int NOT NULL,
  `cpf_empregado` char(11) NOT NULL,
  `cargo` int NOT NULL,
  `sigla_dep` varchar(30) NOT NULL,
  `data_cargo` date NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_sigla_dep4_idx` (`sigla_dep`),
  KEY `fk_cargo_idx` (`cargo`),
  KEY `fk_cpf_empregado_idx` (`cpf_empregado`),
  CONSTRAINT `fk_cargo` FOREIGN KEY (`cargo`) REFERENCES `tbl_cargo` (`codigo`),
  CONSTRAINT `fk_cpf_empregado` FOREIGN KEY (`cpf_empregado`) REFERENCES `tbl_empregado` (`CPF`),
  CONSTRAINT `fk_sigla_dep4` FOREIGN KEY (`sigla_dep`) REFERENCES `tbl_departamento` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_subgerente` (
  `ID` int NOT NULL,
  `cpf_empregado` char(11) NOT NULL,
  `cargo` int NOT NULL,
  `sigla_dep` varchar(30) NOT NULL,
  `data_cargo` date NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_sigla_dep5_idx` (`sigla_dep`),
  KEY `fk_cargo1_idx` (`cargo`),
  KEY `fk_cpf_empregado1_idx` (`cpf_empregado`),
  CONSTRAINT `fk_cargo1` FOREIGN KEY (`cargo`) REFERENCES `tbl_cargo` (`codigo`),
  CONSTRAINT `fk_cpf_empregado1` FOREIGN KEY (`cpf_empregado`) REFERENCES `tbl_empregado` (`CPF`),
  CONSTRAINT `fk_sigla_dep5` FOREIGN KEY (`sigla_dep`) REFERENCES `tbl_departamento` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



/*Inserting information inside the newly created tables*/
INSERT INTO tbl_departamento(sigla, nome)
VALUES ('TI', 'Informática');
INSERT INTO tbl_departamento(sigla, nome)
VALUES ('RH', 'Recursos Humanos'); 
INSERT INTO tbl_departamento(sigla, nome)
VALUES ('BK', 'Falência');
INSERT INTO tbl_departamento(sigla, nome)
VALUES ('MR', 'Manipulação de Remédios');

INSERT INTO tbl_setor(numero, atribuicao, nome, sigla_dep)
VALUES (1, 'Desenvolvimento de Software', 'ONE', 'TI'); 
INSERT INTO tbl_setor(numero, atribuicao, nome, sigla_dep)
VALUES (10, 'Gestão de pessoas', 'TEN', 'RH');
INSERT INTO tbl_setor(numero, atribuicao, nome, sigla_dep)
VALUES (20, 'Analisar renda', 'TWENTY', 'BK');
INSERT INTO tbl_setor(numero, atribuicao, nome, sigla_dep)
VALUES (21, 'Contador', 'TWENTY-ONE', 'BK');
INSERT INTO tbl_setor(numero, atribuicao, nome, sigla_dep)
VALUES (2, 'Software design', 'TWO', 'TI'); 
INSERT INTO tbl_setor(numero, atribuicao, nome, sigla_dep)
VALUES (3, 'Software building', 'THREE', 'TI');  
INSERT INTO tbl_setor(numero, atribuicao, nome, sigla_dep)
VALUES (30, 'Criar remédios', 'THIRTY', 'MR');
INSERT INTO tbl_setor(numero, atribuicao, nome, sigla_dep)
VALUES (31, 'Compactar remédios', 'THIRTY-ONE', 'MR'); 
INSERT INTO tbl_setor(numero, atribuicao, nome, sigla_dep)
VALUES ( 40, 'Marketing de produtos', 'FORTY', 'MR'); 



INSERT INTO tbl_funcao(codigo, descricao)
VALUES (100, 'Desenvolvedor');
INSERT INTO tbl_funcao(codigo, descricao)
VALUES (110, 'Recrutador'); 
INSERT INTO tbl_funcao(codigo, descricao)
VALUES (120, 'Analista financeiro'); 
INSERT INTO tbl_funcao(codigo, descricao) 
VALUES (130, 'Pesquisador');  
INSERT INTO tbl_funcao(codigo, descricao) 
VALUES (140, 'Assessor de Marketing'); 


INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (14565439800, 121212212, 009808998, 'rrrrrr@gmail.com', 6000, 100, 'TI', 1, 'Joberson'); 
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (43243029087, 191919199, 987789098, 'oooooo@gmail.com', 10000, 100, 'TI', 1, 'Odair'); 
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (11122233346, 131313313, 151550076, 'jjjjjj@hotmail.com', 7000, 100, 'TI', 2, 'Marilene'); 
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (12121231221, 141414414, 141447887, 'llllll@outlook.com', 8000, 100, 'TI', 3, 'Robertinho'); 
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (33344432356, 151515515, 131337447, 'trtrtr@gmail.com', 3000, 110, 'RH', 10, 'Rogério');  
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (90909090019, 111111111, 999999999, 'rtrtrtr@outlook.com', 9000, 110, 'RH', 10, 'Rogerum');
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (56565698783, 171717717, 121210990, 'ctctct@gmail.com', 3500, 110, 'RH', 10, 'Durval'); 
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (10011010709, 777171117, 010101100, 'cccccc@yahoo.com.br', 5000, 120, 'BK', 20, 'Langa'); 
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (44440000980, 101010100, 999999898, 'sasasa@yahoo.com.br', 7500, 120, 'BK', 21, 'Arouca'); 
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (88880000345, 988998899, 888888888, 'wwwwww@yahoo.com.br', 9500, 120, 'BK', 20, 'Sampdo');  
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (55550000567, 200220022, 888880880, 'asasas@hotmail.com', 7700, 130, 'MR', 30, 'Robson');
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (77776666090, 300303300, 333334554, 'tststs@yahoo.com.br', 7900, 130, 'MR', 31, 'Jader');
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (99990000124, 307777777, 333555555, 'hhhhhh@yahoo.com.br', 10100, 130, 'MR', 30, 'Jadson'); 
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (12008787991, 000999888, 198709898, 'opopop@outlook.com', 8000, 140, 'MR', 40, 'Roberson');
INSERT INTO tbl_empregado(CPF, RG, celular, email, salario, funcao, sigla_dep, num_set, nome)
VALUES (02209090877, 444565798, 098797676, 'jljljl@hotmail.com', 5000, 140, 'MR', 40, 'Felipe'); 


INSERT INTO tbl_produto(codigo, nome, sigla_dep)
VALUES (007, 'tira-dor','MR');
INSERT INTO tbl_produto(codigo, nome, sigla_dep)
VALUES (008, 'tira-estresse','MR'); 

INSERT INTO tbl_transportadora (CNPJ, localizacao, nome)
VALUES (555565656, 'Av. do Trabalho,800', 'Transportation');
INSERT INTO tbl_transportadora (CNPJ, localizacao, nome)
VALUES (444454545, 'Av. da Tranquilidade,900','Transportando'); 

INSERT INTO tbl_farmacia (CNPJ, nome, localizacao)
VALUES (111123233, 'Venda R', 'Rua do Comércio, 110');
INSERT INTO tbl_farmacia (CNPJ, nome, localizacao)
VALUES (222221122, 'Venda Y', 'Rua do Escambo, 120'); 

INSERT INTO tbl_pedido(numero, valor, cnpj_transp, cnpj_farm)
VALUES (51, 1000, 555565656, 111123233);
INSERT INTO tbl_pedido(numero, valor, cnpj_transp, cnpj_farm)
VALUES (52, 500, 444454545, 222221122);
INSERT INTO tbl_pedido(numero, valor, cnpj_transp, cnpj_farm)
VALUES (53, 250, 555565656, 222221122); 

INSERT INTO tbl_constar(codigo_Prod, numero_Ped, quantidade)
VALUES (007, 51, 25);
INSERT INTO tbl_constar(codigo_Prod, numero_Ped, quantidade)
VALUES (007, 52, 20);
INSERT INTO tbl_constar(codigo_Prod, numero_Ped, quantidade)
VALUES (008, 53, 15); 

INSERT INTO tbl_cargo(codigo, descricao)       
VALUES (1000,'gerente');
INSERT INTO tbl_cargo(codigo, descricao)
VALUES (900,'subgerente'); 


INSERT INTO tbl_gerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo) 
VALUES (120, 43243029087, 1000, 'TI', '2000-05-20');
INSERT INTO tbl_gerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo) 
VALUES (121, 90909090019, 1000, 'RH','2005-07-07');
INSERT INTO tbl_gerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo) 
VALUES (122, 88880000345, 1000, 'BK','2008-09-10');
INSERT INTO tbl_gerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo) 
VALUES (123, 99990000124, 1000, 'MR','2010-02-05'); 

INSERT INTO tbl_subgerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo)
VALUES (91, 14565439800, 900, 'TI', '2010-09-1');
INSERT INTO tbl_subgerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo)
VALUES (92, 11122233346, 900, 'TI', '2011-03-5');
INSERT INTO tbl_subgerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo)
VALUES (93, 12121231221, 900, 'TI', '2012-04-10');
INSERT INTO tbl_subgerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo)
VALUES (94, 33344432356, 900, 'RH', '2009-10-9');
INSERT INTO tbl_subgerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo)
VALUES (95, 10011010709, 900, 'BK', '2008-01-27');
INSERT INTO tbl_subgerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo)
VALUES (96, 44440000980, 900, 'BK', '2013-02-25');
INSERT INTO tbl_subgerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo)
VALUES (97, 55550000567, 900, 'MR', '2014-01-05');
INSERT INTO tbl_subgerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo)
VALUES (98, 77776666090, 900, 'MR', '2012-06-15'); 
INSERT INTO tbl_subgerente(ID, CPF_empregado, cargo, sigla_dep, data_cargo)
VALUES (99, 12008787991, 900, 'MR', '2015-03-03');   

INSERT INTO tbl_orgao_fiscalizador(sigla, ID, nome)
VALUES ('FF', 1345, 'Fiscalizando Financial');
INSERT INTO tbl_orgao_fiscalizador(sigla, ID, nome)
VALUES ('SV', 1678, 'Vigilância Sanitária');
INSERT INTO tbl_orgao_fiscalizador(sigla, ID, nome)
VALUES ('CC', 1907, 'Crimes Cibernéticos'); 

INSERT INTO tbl_fiscaliza(sigla_Org, sigla_Dep)
VALUES ('FF', 'BK');
INSERT INTO tbl_fiscaliza(sigla_Org, sigla_Dep)
VALUES ('SV', 'MR');
INSERT INTO tbl_fiscaliza(sigla_Org, sigla_Dep)
VALUES ('CC', 'TI'); 

INSERT INTO tbl_fornecedor(CNPJ, nome, localizacao)
VALUES (777777999, 'Diroskan Company', 'Av. dos Buracos,500');
INSERT INTO tbl_fornecedor(CNPJ, nome, localizacao)
VALUES (999999456, 'Medicin Ultra Ltda', 'Av. das Árvores,212');


INSERT INTO tbl_fornece(CNPJ_fornec, codigo_prod)
VALUES (777777999, 008);
INSERT INTO tbl_fornece(CNPJ_fornec, codigo_prod)
VALUES (999999456, 007);


/*Starting to elaborate all querys required to obtain the wanted information*/

/* 1 - Quais departamentos possuem mais de um setor? */
/* 1 - Which departments have more than one sector?*/

SELECT tbl_departamento.nome, count(tbl_departamento.nome) as qntd
FROM tbl_departamento
INNER JOIN tbl_setor ON tbl_departamento.sigla = tbl_setor.sigla_dep
GROUP BY tbl_departamento.nome
HAVING qntd > 1; 


/* 2 - Quais departamentos possuem maior número de empregados? */
/* 2 - Which departments have the largest number of employees? */

SELECT tbl_departamento.nome, count(tbl_empregado.CPF) as qtnd
FROM tbl_departamento
INNER JOIN tbl_empregado ON tbl_departamento.sigla = tbl_empregado.sigla_dep
GROUP BY tbl_departamento.nome
ORDER BY qtnd DESC 
LIMIT 2;

/* 3 - Quantos pedidos foram feitos para a empresa?  */
/* 3 - How many orders have been placed for the company?  */
SELECT count(tbl_pedido.numero) 
FROM tbl_pedido;  

/* 4 - Quais setores estão relacionados ao processo de manipulação dos remédios? */
/* 4 - Which departments are related to the drug handling process? */

SELECT tbl_setor.nome, tbl_setor.atribuicao
FROM tbl_departamento
INNER JOIN tbl_setor ON tbl_departamento.sigla = tbl_setor.sigla_dep
WHERE tbl_departamento.sigla = 'MR' 
GROUP BY tbl_setor.atribuicao
ORDER BY tbl_setor.atribuicao
LIMIT 2;  

/* 5 - Qual departamento possui o maior número de subgerentes? */
/* 5 - Which department has the largest number of sub-managers? */

SELECT tbl_departamento.nome, count(tbl_subgerente.ID) as qtnd
FROM tbl_departamento
INNER JOIN tbl_subgerente ON tbl_departamento.sigla = tbl_subgerente.sigla_dep
GROUP BY tbl_departamento.nome
ORDER BY qtnd DESC
LIMIT 1; 

/* 6 - Quanto gerentes possuem mais de 10 anos de serviço na função? */
/* 6 - How many managers have more than 10 years of service in the function? */

SELECT count(tbl_gerente.data_cargo) as qntd
FROM tbl_gerente
WHERE YEAR(CURRENT_DATE()) - YEAR(data_cargo) > 10;  

/* 7 - Quais pedidos incluem 20 ou mais unidades de um produto? */
/* 7 - Which orders include 20 or more units of a product? */

SELECT numero_ped, quantidade
FROM tbl_constar
WHERE quantidade >= 20; 


/* 8 - Quantos empregados ganham mais que 5 mil reais? */
/* 8 - How many employees earn more than 5 thousand reais? */

SELECT count(tbl_empregado.salario)
FROM tbl_empregado
WHERE salario > 5000;  

/* 9 - Quantos departamentos estão sendo investigados? */
/* 9 - How many departments are being investigated? */

SELECT count(sigla_dep)
FROM tbl_fiscaliza;  

/* 10 - Quantos órgãos fiscalizadores estão fiscalizando a empresa? */
/* 10 - How many inspection agencies are inspecting the company? */

SELECT count(sigla_org)
FROM tbl_fiscaliza;

/* 11 - Qual farmácia realiza o maior número de pedidos? */
/* 11 - Which pharmacy makes the largest number of orders? */

SELECT tbl_farmacia.nome, count(tbl_pedido.numero) as qntd
FROM tbl_farmacia
INNER JOIN tbl_pedido ON tbl_farmacia.CNPJ = tbl_pedido.cnpj_farm
GROUP BY tbl_farmacia.nome
ORDER BY qntd DESC
LIMIT 1; 

/* 12 - Quantos fornecedores fornecem matéria-prima para a fabricação dos remédios? */
/* 12 - How many suppliers provide raw material for the manufacturing of the drugs? */

SELECT count(tbl_fornece.cnpj_fornec)
FROM tbl_fornece;

/* 13 - Quais setores tem o maior número de empregados? */
/* 13 - Which sectors have the largest number of employees? */

SELECT tbl_setor.nome, count(tbl_empregado.CPF) as qtnd
FROM tbl_setor
INNER JOIN tbl_empregado ON tbl_setor.atribuicao = tbl_empregado.atribuicao_set
GROUP BY tbl_setor.nome
ORDER BY qtnd DESC 
LIMIT 2; 

/* 14 - Quais funções um empregado pode ter? */
/* 14 - What functions can an employee have? */

SELECT descricao, codigo
FROM tbl_funcao;

/* 15 - Quantos subgerentes estão a menos de 7 anos na função? */
/* 15 - How many assistant managers have been in the position less than 7 years? */

SELECT count(tbl_subgerente.data_cargo) as qntd
FROM tbl_subgerente
WHERE YEAR(CURRENT_DATE()) - YEAR(data_cargo) < 9; 

/* 16 - Qual transportadora transporta o maior número de pedidos? */
/* 16 - Which carrier carries the most orders? */

SELECT tbl_transportadora.nome, count(tbl_pedido.numero) as qntd
FROM tbl_transportadora
INNER JOIN tbl_pedido ON tbl_transportadora.localizacao = tbl_pedido.local_transp
GROUP BY tbl_transportadora.nome
ORDER BY qntd DESC
LIMIT 1; 

/* 17 - Quais setores estão encarregados de realizar o marketing dos medicamentos? */ 
/* 17 - Which sectors are in charge of marketing the drugs? */

SELECT tbl_setor.nome, tbl_setor.atribuicao
FROM tbl_departamento
INNER JOIN tbl_setor ON tbl_departamento.sigla = tbl_setor.sigla_dep
WHERE tbl_departamento.sigla = 'MR' 
GROUP BY tbl_setor.atribuicao
ORDER BY tbl_setor.atribuicao DESC
LIMIT 1; 

/* 18 - Qual a média de unidades de produto nos pedidos feitos a empresa? */
/* 18 - What is the average number of product units in the orders placed at the company? */

SELECT avg(quantidade)
FROM tbl_constar;

/* 19 - Quantos empregados estão listados como subgerentes na empresa? */
/* 19 - How many employees are listed as sub-managers in the company? */

SELECT count(tbl_subgerente.ID) as qntd 
FROM tbl_subgerente; 

/* 20 - Soma de todas as unidades de produto presentes nos pedidos feitos a empresa? */
/* 20 - Sum of all the product units present in the orders placed with the company? */

SELECT sum(quantidade)
FROM tbl_constar;


/* 21 - Quais empregados possuem funcao X e também são gerentes? */
/* 21 - Which employees have role X and are also managers? */

/* Produto Cartesiano */
SELECT DISTINCT tbl_empregado.nome FROM tbl_empregado, tbl_gerente, tbl_funcao
WHERE tbl_empregado.CPF = tbl_gerente.cpf_empregado
AND tbl_empregado.funcao = tbl_funcao.codigo AND tbl_funcao.descricao = "Desenvolvedor";

/* Junção */
SELECT DISTINCT tbl_empregado.nome
FROM tbl_empregado
INNER JOIN tbl_gerente ON tbl_empregado.CPF = tbl_gerente.cpf_empregado 
INNER JOIN tbl_funcao ON tbl_empregado.funcao = tbl_funcao.codigo AND tbl_funcao.descricao = "Desenvolvedor";


/* 22 - Apresente a relação de todos os produtos que não foram pedidos com quantidade maior que 20? */
/* 22 - List all the products that were not ordered with quantity greater than 20? */

SELECT codigo_prod 
FROM tbl_constar
WHERE codigo_prod not in (SELECT codigo_prod FROM tbl_constar WHERE quantidade > 20)
GROUP BY codigo_prod;



/*Transaction operations - EXAMPLES*/


/* 1st EXAMPLE: A first possibility to use transaction management in the database is to start a transaction in order to be able to insert
values into specific tables. In the example below, the transaction is started in order to
to insert values determined by the dev in the supplier and product tables. */

START TRANSACTION;
INSERT INTO tbl_fornecedor(CNPJ, nome, localizacao) VALUES (56756756, 'No ltda', 'Rua dos Barões,119'); 
INSERT INTO tbl_produto(codigo, nome, sigla_dep) VALUES (9, 'antialérgico', 'MR');
COMMIT; 

/* 2nd EXAMPLE: A second possibility to use transaction operations is to change existing values
within the tables created by other values determined by the dev. In the example below, the designated operation is changing
the name of the product just entered into the database by another. */

START TRANSACTION;
SELECT nome
FROM tbl_produto
WHERE codigo = 9;

UPDATE tbl_produto
SET nome = 'Devolve sono'
WHERE codigo = 9;

COMMIT; 














