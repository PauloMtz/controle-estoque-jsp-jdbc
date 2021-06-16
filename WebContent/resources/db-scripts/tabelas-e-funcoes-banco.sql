CREATE TABLE `itens` (
  `id_item` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `codigo_erp` varchar(10) NOT NULL,
  `part_number` varchar(65) DEFAULT NULL,
  `fabricante` varchar(65) DEFAULT NULL,
  `maquina` varchar(30) DEFAULT NULL,
  `dimensoes` varchar(65) DEFAULT NULL,
  `posicao_almox` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `entrada_item` (
  `id_entrada` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `fornecedor` varchar(65) DEFAULT NULL,
  `contrato` varchar(20) DEFAULT NULL,
  `quantidade` int(5) CHECK (`quantidade` > 0),
  `valor_total` double(9,2) DEFAULT NULL,
  `custo_unitario` double(6,2) DEFAULT NULL,
  `data_recebimento` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (item_id) REFERENCES itens (id_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `saida_item` (
  `id_saida` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `solicitante` varchar(65) DEFAULT NULL,
  `quantidade` int(5) CHECK (`quantidade` > 0),
  `finalidade` varchar(20) DEFAULT NULL,
  `valor_total` double(9,2) DEFAULT NULL,
  `custo_unitario` double(6,2) DEFAULT NULL,
  `observacao` text,
  `data_saida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (item_id) REFERENCES itens (id_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `estoque` (
  `id_estoque` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `quantidade` int(11) CHECK (`quantidade` > 0),
  `custo_unitario` double(6,2) DEFAULT NULL,
  `valor_total` double(9,2) DEFAULT NULL,
  FOREIGN KEY (item_id) REFERENCES itens (id_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(65) NOT NULL,
  `matricula` varchar(20) NOT NULL UNIQUE,
  `email` varchar(65) NOT NULL,
  `senha` varchar(32) NOT NULL,
  `perfil` varchar(20) DEFAULT NULL,
  `ativo` boolean DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `itens` VALUES 
	(1,'CORREIA PLANA','TC0049','AS-004-BD-77-MM','NPI','DBCS','12x123x2345','21.B.08'),
	(2,'CORREIA REDONDA','TC0081','12-FF-03-XX','TESTE','OVIS','12x10x189','21.C.07'),
	(3,'ROLAMENTO Z6204','TR0040','XX-Z09-BG-34','WEG','Crisplant','','22.C.09'),
	(4,'PARAFUSO M10','M1100','AA-11-BB-CC','TESTE','Crossbelt','10mm','22.X.8');

INSERT INTO `usuarios` VALUES
	(1,'JOSÉ TESTE','2323423','jose@email.com','202cb962ac59075b964b07152d234b70','admin',1);

# stored procedure para atualizar estoque após adicionar item
DELIMITER $$
CREATE PROCEDURE `SP_AtualizaEstoque` ( `item` int, `qtde` int, `total_item` decimal(9,2), `custo_unitario` decimal(6,2))
BEGIN 
declare contador int(11);
SELECT count(*) into contador FROM estoque WHERE item_id = item;
IF contador > 0 THEN 
UPDATE estoque SET quantidade = quantidade + qtde, valor_total = valor_total + total_item, custo_unitario = COALESCE(valor_total / NULLIF(quantidade, 0), 0) WHERE item_id = item;
ELSE
INSERT INTO estoque (item_id, quantidade, valor_total, custo_unitario) values (item, qtde, total_item, custo_unitario); 
END IF; 
END $$ 
DELIMITER ;

# trigger que chama a stored procedure para atualizar banco
DELIMITER $$ 
CREATE TRIGGER `TRG_EntradaItem_AI` AFTER INSERT ON `entrada_item` 
FOR EACH ROW 
BEGIN 
CALL SP_AtualizaEstoque (new.item_id, new.quantidade, new.valor_total, new.custo_unitario); 
END $$ 
DELIMITER ;

# trigger que chama a stored procedure para atualizar banco
DELIMITER $$
CREATE TRIGGER `TRG_SaidaItem_AI` AFTER INSERT ON `saida_item` 
FOR EACH ROW 
BEGIN 
CALL SP_AtualizaEstoque (new.item_id, new.quantidade * -1, new.valor_total * -1, new.custo_unitario); 
END $$ 
DELIMITER ;
