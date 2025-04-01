# Testes de Nivelamento - ANS (Agência Nacional de Saúde Suplementar)

Este repositório contém a implementação de quatro testes técnicos focados em **web scraping**, **transformação de dados**, **banco de dados** e **desenvolvimento de API**. O projeto foi desenvolvido para demonstrar habilidades em automação, manipulação de dados e integração entre sistemas, seguindo requisitos específicos da ANS.

---

## 📋 Visão Geral do Projeto

### **1. Teste de Web Scraping**  
**Objetivo:** Automatizar o download dos Anexos I e II (PDFs) do site da ANS e compactá-los em um arquivo ZIP.  
**Linguagem:** Python  
**Ferramentas:** `requests`, `BeautifulSoup`, `zipfile`  

### **2. Teste de Transformação de Dados**  
**Objetivo:** Extrair tabelas de um PDF (Anexo I), converter para CSV, substituir abreviações (OD → Odontológico, AMB → Ambulatorial) e compactar o resultado.  
**Linguagem:** Python  
**Ferramentas:** `PyMuPDF (fitz)`, `pandas`  

### **3. Teste de Banco de Dados**  
**Objetivo:** Criar um banco de dados, importar dados públicos da ANS (CSV) e executar consultas analíticas para identificar operadoras com maiores despesas.  
**Linguagem:** SQL (MySQL)  
**Ferramentas:** Scripts de criação de tabelas, queries de importação e análise.  

### **4. Teste de API**  
**Objetivo:** Desenvolver uma interface web (frontend) para busca de operadoras, integrada a um servidor backend que processa dados CSV.  
**Linguagens:** Vue.js (frontend), Node.js (backend)  
**Ferramentas:** `Express.js`, `axios`, `csv-parser`  

---

## 🛠️ Tecnologias Utilizadas

| Área          | Ferramentas                                                                 |
|---------------|-----------------------------------------------------------------------------|
| **Backend**   | Python, Node.js, MySQL                                                     |
| **Frontend**  | Vue.js, HTML, CSS                                                          |
| **Bibliotecas**| Pandas, PyMuPDF, BeautifulSoup, Express.js, Axios                          |
| **Versionamento**| Git, GitHub                                                              |

---

## 📂 Estrutura do Projeto
teste-de-nivelamento/
├── web_scraping/
│ └── scraper.py # Script para download e compactação de PDFs
├── transformacao_dados/
│ ├── extractor.py # Script de extração de PDF para CSV
│ └── procedimentos.csv # Arquivo gerado (exemplo)
├── database/
│ ├── dados.sql # Scripts SQL (tabelas, importação, queries)
│ └── demonstracoes_contabeis/ # Dados importados (exemplo)
├── vue/
│ ├── src/
│ │ └── components/
│ │ └── search.vue # Componente de busca (frontend)
│ ├── server.js # Servidor Node.js (backend)
│ ├── package.json # Dependências do Vue/Node
│ └── package-lock.json
└── README.md # Documentação do projeto



---

## 🚀 Como Executar o Projeto

### **Pré-requisitos**  
- Python 3.8+
- Node.js 14+
- MySQL 8.0+
- Git

### **Passo a Passo**  

1. **Clone o Repositório**  
   ```bash
   git clone https://github.com/seu-usuario/teste-de-nivelamento.git
   cd teste-de-nivelamento
Web Scraping (Teste 1)


cd web_scraping
pip install requests beautifulsoup4
python scraper.py
Transformação de Dados (Teste 2)

cd ../transformacao_dados
pip install pymupdf pandas
python extractor.py
Banco de Dados (Teste 3)

Importe o arquivo database/dados.sql no MySQL.

Certifique-se de que os CSVs estejam na pasta downloads/.

API (Teste 4)


cd ../vue
npm install                   # Instala dependências do Vue/Node
node server.js               # Inicia o servidor backend (porta 3000)
npm run serve                # Inicia o frontend (porta 8080)
📌 Notas Importantes
Substituição de Abreviações (Teste 2):
As colunas "OD" e "AMB" no CSV são automaticamente convertidas para "Odontológico" e "Ambulatorial".

Compatibilidade do Banco de Dados:
Os scripts SQL foram otimizados para MySQL. Para PostgreSQL, ajuste os comandos LOAD DATA INFILE para COPY.

Melhorias Futuras:

Adicionar autenticação à API.

Implementar paginação nos resultados de busca.

📄 Licença
Este projeto é destinado para fins de avaliação técnica. O uso comercial requer autorização prévia.

✉️ Contato
Desenvolvedor: Victor Almeida Santos
Email: victor2002almeida@gmail.com
LinkedIn: linkedin.com/in/vaspicoli


Este README foi estruturado para **clareza técnica** e **facilidade de reprodução**, seguindo boas práticas de documentação. Adapte os campos de contato e URLs conforme necessário! 😊
