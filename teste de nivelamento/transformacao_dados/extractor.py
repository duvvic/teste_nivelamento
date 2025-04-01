import fitz  # PyMuPDF
import pandas as pd
import os
import zipfile
from itertools import chain

def extrair_dados_pdf():
    print("Iniciando transformação de dados...")
    
    try:
        pdf_path = os.path.join("downloads", "Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf")
        
        # Verifica se o arquivo existe
        if not os.path.exists(pdf_path):
            raise FileNotFoundError(f"Arquivo PDF não encontrado em: {pdf_path}")

        print("Extraindo texto do PDF...")
        doc = fitz.open(pdf_path)
        texto_completo = []
        
        for pagina in doc:
            texto = pagina.get_text()
            texto_completo.append(texto)
        
        # Processamento básico do texto (adaptar conforme estrutura real)
        linhas = list(chain(*[t.split('\n') for t in texto_completo]))
        dados = [linha.split() for linha in linhas if linha.strip()]
        
        # Criar DataFrame (simplificado - ajuste conforme necessário)
        df = pd.DataFrame(dados)
        
        # 2.4 - Substituir abreviações
        df.replace({
            "OD": "Odontológico",
            "AMB": "Ambulatorial"
        }, inplace=True)
        
        # 2.2 - Salvar CSV
        csv_path = "procedimentos.csv"
        df.to_csv(csv_path, index=False, encoding='utf-8-sig')
        print(f"Dados salvos em: {csv_path}")
        
        # 2.3 - Compactar
        zip_path = "victor_almeida.zip"
        with zipfile.ZipFile(zip_path, 'w') as zipf:
            zipf.write(csv_path)
        
        print(f"Arquivo compactado gerado: {zip_path}")
        print("Processo concluído com sucesso!")
        
    except Exception as e:
        print(f"Ocorreu um erro: {e}")

if __name__ == "__main__":
    extrair_dados_pdf()