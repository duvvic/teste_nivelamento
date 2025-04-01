CREATE DATABASE IF NOT EXISTS ans_data;
USE ans_data;

CREATE TABLE IF NOT EXISTS operadoras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registro_ans VARCHAR(20) UNIQUE,
    cnpj VARCHAR(20),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(50),
    uf CHAR(2),
    endereco TEXT,
    telefone VARCHAR(20),
    site VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,                      -- Data do registro
    registro_ans VARCHAR(20),       -- Chave para relacionar com operadoras
    cd_conta_contabil VARCHAR(20),  -- Código da conta contábil
    descricao VARCHAR(255),         -- Descrição da conta
    vl_saldo_inicial DECIMAL(15,2),   -- Valor do saldo inicial
    vl_saldo_final DECIMAL(15,2)      -- Valor do saldo final
);

LOAD DATA INFILE 'downloads/Relatorio_cadop.csv'
INTO TABLE operadoras
CHARACTER SET utf8  -- ou outro encoding, se necessário (ex.: latin1)
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, endereco, telefone, site);

LOAD DATA INFILE 'downloads/2023-1.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8  -- ou latin1, conforme o arquivo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA INFILE 'downloads/2023-2.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8  -- ou latin1, conforme o arquivo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

    LOAD DATA INFILE 'downloads/2023-3.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8  -- ou latin1, conforme o arquivo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

    LOAD DATA INFILE 'downloads/2023-4.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8  -- ou latin1, conforme o arquivo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

    LOAD DATA INFILE 'downloads/2024-1.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8  -- ou latin1, conforme o arquivo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

    LOAD DATA INFILE 'downloads/2024-2.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8  -- ou latin1, conforme o arquivo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

    LOAD DATA INFILE 'downloads/2024-3.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8  -- ou latin1, conforme o arquivo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

    LOAD DATA INFILE 'downloads/2024-4.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8  -- ou latin1, conforme o arquivo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, registro_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

SELECT 
    o.razao_social, 
    -SUM(dc.vl_saldo_final) AS total_despesa
FROM demonstracoes_contabeis dc
JOIN operadoras o 
    ON dc.registro_ans = o.registro_ans
WHERE (dc.descricao LIKE '%EVENTOS/SINISTROS CONHECIDOS%' 
       OR dc.descricao LIKE '%AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%')
  AND dc.data >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY o.razao_social
ORDER BY total_despesa DESC
LIMIT 10;


SELECT 
    o.razao_social, 
    -SUM(dc.vl_saldo_final) AS total_despesa
FROM demonstracoes_contabeis dc
JOIN operadoras o 
    ON dc.registro_ans = o.registro_ans
WHERE (dc.descricao LIKE '%EVENTOS/SINISTROS CONHECIDOS%' 
       OR dc.descricao LIKE '%AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%')
  AND dc.data >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY o.razao_social
ORDER BY total_despesa DESC
LIMIT 10;
